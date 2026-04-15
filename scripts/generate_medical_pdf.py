"""
Generate PDF patient medical records for the last 10 pets with OPD activity.
Uses fpdf2 for proper Thai Unicode rendering.

Usage:
    python -m scripts.generate_medical_pdf

Output: ./output/medical_record_<petid>.pdf  (one file per pet)
"""

import os
import re
from datetime import datetime
from html.parser import HTMLParser

import pymysql
import pymysql.cursors
from fpdf import FPDF

from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME

OUTPUT_DIR = os.path.join(os.path.dirname(__file__), "..", "output")

# ---------------------------------------------------------------------------
# Thai font paths (Leelawadee preferred, fallback to Tahoma)
# ---------------------------------------------------------------------------
_LEELAWAD_REG  = r"C:\Windows\Fonts\LEELAWAD.TTF"
_LEELAWAD_BOLD = r"C:\Windows\Fonts\LEELAWDB.TTF"
_TAHOMA_REG    = r"C:\Windows\Fonts\tahoma.ttf"
_TAHOMA_BOLD   = r"C:\Windows\Fonts\tahomabd.ttf"

if os.path.exists(_LEELAWAD_REG):
    _FONT_REG  = _LEELAWAD_REG
    _FONT_BOLD = _LEELAWAD_BOLD if os.path.exists(_LEELAWAD_BOLD) else _LEELAWAD_REG
else:
    _FONT_REG  = _TAHOMA_REG
    _FONT_BOLD = _TAHOMA_BOLD

# ---------------------------------------------------------------------------
# Colour palette
# ---------------------------------------------------------------------------
_C_DARK_BLUE  = (26,  60,  94)
_C_MID_BLUE   = (56,  100, 148)
_C_LIGHT_BLUE = (240, 245, 251)
_C_ROW_HEAD   = (220, 232, 244)
_C_BORDER     = (196, 214, 228)
_C_WHITE      = (255, 255, 255)
_C_GREY       = (130, 130, 130)
_C_BLACK      = (0,   0,   0)


# ---------------------------------------------------------------------------
# Utility helpers
# ---------------------------------------------------------------------------

# Characters Leelawadee doesn't have a glyph for — map the common ones to
# readable ASCII equivalents and silently drop the rest.
_CHAR_MAP = {
    '\u2192': '->',   # →
    '\u2190': '<-',   # ←
    '\u21d2': '=>',   # ⇒
    '\u21d0': '<=',   # ⇐
    '\u2191': '^',    # ↑
    '\u2193': 'v',    # ↓
    '\u2014': '-',    # em dash
    '\u2013': '-',    # en dash
    '\u2018': "'",   # left single quote
    '\u2019': "'",   # right single quote
    '\u201c': '"',   # left double quote
    '\u201d': '"',   # right double quote
    '\u2026': '...',  # ellipsis
    '\u2022': '*',    # bullet •
    '\u25cf': '*',    # black circle
    '\u2713': '/',    # check mark ✓
    '\u2715': 'x',    # cross ✕
}


def _sanitize(s: str) -> str:
    """Replace or remove characters outside Leelawadee's glyph coverage."""
    if not s:
        return s
    # Apply known mappings first
    for ch, replacement in _CHAR_MAP.items():
        s = s.replace(ch, replacement)
    # Keep only chars in ranges Leelawadee covers:
    #   Basic ASCII (0020-007E), Latin-1 Supplement (00A0-00FF),
    #   Latin Extended A/B (0100-024F), Thai (0E00-0E7F).
    # Everything else (arrows, symbols, emoji, etc.) is dropped.
    result = []
    for ch in s:
        cp = ord(ch)
        if (0x0020 <= cp <= 0x007E
                or 0x00A0 <= cp <= 0x00FF
                or 0x0100 <= cp <= 0x024F
                or 0x0E00 <= cp <= 0x0E7F):
            result.append(ch)
    return ''.join(result)


def decode_blob(val):
    if isinstance(val, (bytes, bytearray)):
        try:
            return val.decode("utf-8")
        except Exception:
            return ""
    return val or ""


def txt(val):
    s = str(decode_blob(val)).strip() if val is not None else ""
    s = s.replace("\r", " ").replace("\n", " ")
    return _sanitize(s)


def fmt_dt(val):
    if val is None:
        return ""
    if isinstance(val, datetime):
        return val.strftime("%d/%m/%Y %H:%M")
    return str(val)


class _StripHTML(HTMLParser):
    def __init__(self):
        super().__init__()
        self._parts = []

    def handle_data(self, data):
        self._parts.append(data)

    def handle_entityref(self, name):
        import html
        self._parts.append(html.unescape(f"&{name};"))

    def handle_charref(self, name):
        import html
        self._parts.append(html.unescape(f"&#{name};"))

    def result(self):
        return _sanitize(re.sub(r"\s+", " ", " ".join(self._parts)).strip())


def strip_html(val):
    raw = decode_blob(val)
    if not raw:
        return ""
    try:
        p = _StripHTML()
        p.feed(raw)
        return p.result()
    except Exception:
        return raw


def _sanitize_multiline(s: str) -> str:
    """Like _sanitize but preserves newline structure."""
    if not s:
        return s
    lines = s.split("\n")
    cleaned = [_sanitize(re.sub(r"[ \t]+", " ", ln).strip()) for ln in lines]
    result = "\n".join(cleaned)
    result = re.sub(r"\n{2,}", "\n", result)   # collapse all consecutive blank lines to one separator
    return result.strip()


class _RichHTMLParser(HTMLParser):
    """HTML parser that converts block/list tags to newlines and bullets."""
    _BLOCK_TAGS = {"p", "div", "h1", "h2", "h3", "h4", "h5", "h6",
                   "tr", "blockquote", "ul", "ol"}

    def __init__(self):
        super().__init__()
        self._parts = []

    def handle_starttag(self, tag, attrs):
        if tag == "br":
            self._parts.append("\n")
        elif tag == "li":
            self._parts.append("\n- ")
        elif tag in self._BLOCK_TAGS:
            # Ensure a newline before the block's content so paragraphs never merge
            self._parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self._BLOCK_TAGS:
            self._parts.append("\n")
        elif tag == "li":
            self._parts.append("\n")

    def handle_data(self, data):
        self._parts.append(data)

    def handle_entityref(self, name):
        import html
        self._parts.append(html.unescape(f"&{name};"))

    def handle_charref(self, name):
        import html
        self._parts.append(html.unescape(f"&#{name};"))

    def result(self):
        return _sanitize_multiline("".join(self._parts))


def strip_html_rich(val):
    """Strip CKEditor HTML, preserving paragraphs and list items as plain text."""
    raw = decode_blob(val)
    if not raw:
        return ""
    try:
        p = _RichHTMLParser()
        p.feed(raw)
        return p.result()
    except Exception:
        return strip_html(val)


def rich_txt(val):
    """Normalize CKEditor/richbox text to trimmed plain text."""
    return str(strip_html_rich(val) or "").strip()


def normalize_wrap_text(val):
    """Normalize multiline table text so measurement and rendering are identical."""
    raw = ("" if val is None else str(val)).replace("\r", "")
    lines = [ln.strip() for ln in raw.split("\n") if ln.strip()]
    return "\n".join(lines)


def display_or_na(val, fallback="-"):
    """Display-safe text with fallback when value is empty."""
    s = ("" if val is None else str(val)).strip()
    return s if s else fallback


# ---------------------------------------------------------------------------
# Database helpers
# ---------------------------------------------------------------------------

def get_connection():
    return pymysql.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME,
        charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor,
    )


def get_last_10_pets(conn):
    sql = """
        SELECT p.uid AS pet_uid, p.petid, p.petname, p.pettype, p.petbreed,
               p.petsex, p.petbirthday, p.petageyear, p.petagemonth,
               p.petageday, p.petnote, p.cuid,
               MAX(o.opd_datetime) AS last_visit
        FROM pet p
        INNER JOIN opd o ON o.pet_uid = p.uid
        WHERE o.opd_status = 1
        GROUP BY p.uid
        ORDER BY last_visit DESC
        LIMIT 10
    """
    with conn.cursor() as cur:
        cur.execute(sql)
        return cur.fetchall()


def get_customer(conn, cuid):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT title, firstname, lastname, tel_1, mobile_1, "
            "address, soi, road, tumbon, ampor, province, zipcode "
            "FROM customer WHERE uid = %s", (cuid,))
        return cur.fetchone()


def get_opds(conn, pet_uid):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT opd_id, queue_uid, opd_datetime, doctor_name, "
            "opd_T, opd_P, opd_R, opd_weight_kg, opd_pain_score, "
            "opd_cc, suggestion, reportlab "
            "FROM opd WHERE pet_uid = %s AND opd_status = 1 "
            "ORDER BY opd_datetime DESC", (pet_uid,))
        return cur.fetchall()


def get_physical_exam(conn, queue_uid):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT more_info, pet_weight, pet_temperature, pet_bp, "
            "pet_hr, pet_rr, pet_bcs, pet_mm, pet_crt, hydration, "
            "content, treatment, comment "
            "FROM queue_history WHERE queue_uid = %s", (queue_uid,))
        return cur.fetchone()


def get_vaccines(conn, opd_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT s.stock_name AS vaccine_name, ov.content, ov.status, ov.timestamp "
            "FROM opd_vaccine ov LEFT JOIN stock s ON s.uid = ov.stock_uid "
            "WHERE ov.opd_id = %s ORDER BY ov.timestamp", (opd_id,))
        return cur.fetchall()


def get_prognosis(conn, opd_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT content, timestamp FROM opd_prognosis "
            "WHERE opd_id = %s ORDER BY timestamp", (opd_id,))
        return cur.fetchall()


def get_treatment(conn, opd_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT content, timestamp FROM opd_treatment "
            "WHERE opd_id = %s ORDER BY timestamp", (opd_id,))
        return cur.fetchall()


def get_labs(conn, opd_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT ol.product, ol.timestamp, ol.lab_status "
            "FROM opd_lab ol WHERE ol.opd_id = %s AND ol.status = 1 "
            "ORDER BY ol.timestamp", (opd_id,))
        return cur.fetchall()


# -- Admit helpers -----------------------------------------------------------

def get_admit_histories(conn, pet_uid):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT ah.admit_history_id, ah.admit_since_date, ah.admit_to_date, "
            "ah.admit_status, ast.admit_status_name, ah.doctor_id, "
            "ah.history, ah.physical, ah.differential, ah.final, "
            "ah.prognosis, ah.suggestion, ah.reportlab, ah.admit_status_text "
            "FROM admit_history ah "
            "LEFT JOIN admit_status ast ON ast.admit_status_id = ah.admit_status "
            "WHERE ah.pet_uid = %s "
            "ORDER BY ah.admit_since_date DESC", (pet_uid,))
        return cur.fetchall()


def get_admit_labs(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT product, timestamp, lab_status "
            "FROM admit_lab "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_body(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_body_f_time, monitor_body_f, "
            "monitor_body_hr_time, monitor_body_hr, "
            "monitor_body_rr_time, monitor_body_rr, "
            "monitor_body_bp_time, monitor_body_bp, "
            "monitor_body_mm_time, monitor_body_mm, "
            "monitor_body_crt_time, monitor_body_crt, "
            "monitor_body_uop_time, monitor_body_uop, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_body "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_eat(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_eat_time, monitor_eat_type, monitor_eat_isme, "
            "monitor_eat_cc, veterinary, assistant, timestamp "
            "FROM admit_monitor_eat "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_general(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_general_urine_time, monitor_general_urine, monitor_general_urine_cc, "
            "monitor_general_vomit_time, monitor_general_vomit, monitor_general_vomit_cc, "
            "monitor_general_oh_time, monitor_general_oh, monitor_general_oh_cc, "
            "monitor_general_cough_time, monitor_general_cough, "
            "monitor_general_coma_time, monitor_general_coma, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_general "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_other(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_other_time, monitor_other_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_other "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_plan(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_plan_time_set1, monitor_plan_time_set2, "
            "monitor_plan_content, veterinary, assistant, timestamp "
            "FROM admit_monitor_plan "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_talk(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_talk_time, monitor_talk_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_talk "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


def get_admit_monitor_treatment(conn, admit_history_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT monitor_other_time, monitor_other_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_treatment "
            "WHERE admit_history_id = %s AND status = 1 "
            "ORDER BY timestamp", (admit_history_id,))
        return cur.fetchall()


# ---------------------------------------------------------------------------
# PDF layout
# ---------------------------------------------------------------------------

class MedicalPDF(FPDF):

    def __init__(self):
        super().__init__(format="A4")
        self.add_font("Thai",  "",  _FONT_REG)
        self.add_font("Thai", "B", _FONT_BOLD)
        self.set_margins(16, 18, 16)
        self.set_auto_page_break(auto=True, margin=20)

    @property
    def pw(self):
        """Effective print width."""
        return self.epw

    def _c(self, rgb, fill=False, draw=False, text=False):
        r, g, b = rgb
        if fill:
            self.set_fill_color(r, g, b)
        if draw:
            self.set_draw_color(r, g, b)
        if text:
            self.set_text_color(r, g, b)

    # -- Section elements --

    def doc_title(self, text):
        self.set_font("Thai", "B", 16)
        self._c(_C_DARK_BLUE, fill=True)
        self._c(_C_WHITE, text=True)
        self.cell(self.pw, 10, text, fill=True, new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        self.ln(3)

    def section_banner(self, text):
        self.set_font("Thai", "B", 11)
        self._c(_C_MID_BLUE, fill=True)
        self._c(_C_WHITE, text=True)
        self.cell(self.pw, 8, "  " + text, fill=True, new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        self.ln(1)

    def sub_label(self, text):
        self.set_font("Thai", "B", 10)
        self._c(_C_DARK_BLUE, text=True)
        self.cell(self.pw, 7, text, new_x="LMARGIN", new_y="NEXT")
        # dashed underline
        self._c(_C_BORDER, draw=True)
        self.set_line_width(0.2)
        self.set_dash_pattern(dash=2, gap=1)
        y = self.get_y()
        self.line(self.l_margin, y, self.l_margin + self.pw, y)
        self.set_dash_pattern()
        self._c(_C_BLACK, text=True)
        self.ln(1)

    def empty_row(self):
        self.set_font("Thai", "", 9)
        self._c(_C_GREY, text=True)
        self.cell(self.pw, 5, "-", new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        self.ln(1)

    def text_block(self, text, size=10):
        t = str(text).strip() if text else ""
        if not t:
            self.empty_row()
            return
        self.set_font("Thai", "", size)
        # Split on newlines so \n is never passed as a glyph to the font renderer.
        paragraphs = t.split("\n")
        for para in paragraphs:
            stripped = para.strip()
            if stripped:
                self.multi_cell(self.pw, 5.5, stripped)
        self.ln(1)

    # -- Data renderers --

    def render_vitals(self, pe):
        if not pe:
            self.empty_row()
            return
        checks = [
            ("น้ำหนัก",    pe.get("pet_weight"),      "kg"),
            ("อุณหภูมิ",   pe.get("pet_temperature"), "°C"),
            ("HR",         pe.get("pet_hr"),           "bpm"),
            ("RR",         pe.get("pet_rr"),           "/min"),
            ("BP",         pe.get("pet_bp"),           ""),
            ("MM",         pe.get("pet_mm"),           ""),
            ("CRT",        pe.get("pet_crt"),          "s"),
            ("BCS",        pe.get("pet_bcs"),          ""),
            ("Hydration",  pe.get("hydration"),        ""),
        ]
        active = [
            (label, f"{txt(val)} {unit}".strip())
            for label, val, unit in checks
            if val and txt(val) not in ("", "0", "0.0")
        ]
        if active:
            cols = min(len(active), 4)
            cw = self.pw / cols
            self._c(_C_LIGHT_BLUE, fill=True)
            self._c(_C_BORDER, draw=True)
            self.set_line_width(0.2)
            self.set_dash_pattern()
            for i, (label, val) in enumerate(active):
                if i > 0 and i % cols == 0:
                    self.ln()
                    self.set_x(self.l_margin)
                self.set_font("Thai", "B", 9)
                self.cell(cw * 0.44, 6, label + ":", border=1, fill=True)
                self.set_font("Thai", "", 9)
                self.cell(cw * 0.56, 6, val, border=1, fill=True)
            self.ln()
        note = rich_txt(pe.get("more_info"))
        if note:
            self.ln(1)
            self.text_block(note)
        else:
            self.ln(1)

        for label, field in [
            ("(PE Notes)", rich_txt(pe.get("content"))),
            ("(Treatment)", rich_txt(pe.get("treatment"))),
            ("(Comment)", rich_txt(pe.get("comment"))),
        ]:
            if field and field.strip():
                self.sub_label(label)
                self.text_block(field.strip())

    def render_table(self, headers, rows, col_widths=None, multiline_cols=None):
        """
        multiline_cols: int or iterable of column indexes that should wrap.
        e.g. 1 or {1} means second column wraps, rest are single-line.
        If None, all columns use single-line cell (original behaviour).
        """
        if not rows:
            self.empty_row()
            return

        n = len(headers)
        cws = col_widths or [self.pw / n] * n
        if multiline_cols is None:
            ml_cols = set()
        elif isinstance(multiline_cols, int):
            ml_cols = {multiline_cols}
        else:
            ml_cols = set(multiline_cols)

        # ── Header row ──
        self._c(_C_ROW_HEAD, fill=True)
        self._c(_C_BORDER, draw=True)
        self.set_line_width(0.2)
        self.set_dash_pattern()
        self.set_font("Thai", "B", 9)
        for h, w in zip(headers, cws):
            self.cell(w, 7, h, border=1, fill=True)
        self.ln()

        # ── Data rows ──
        self.set_font("Thai", "", 9)
        self._c(_C_WHITE, fill=True)

        line_h = 6
        page_bottom = self.h - self.b_margin

        for row in rows:
            # Check if this row has any multiline column
            if not ml_cols:
                # Fast path: all single-line (original behaviour)
                if self.get_y() + line_h > page_bottom:
                    self.add_page()
                for val, w in zip(row, cws):
                    safe = str(val).replace("\r", " ").replace("\n", " ")
                    safe = display_or_na(safe)
                    self.cell(w, line_h, safe, border=1, fill=True)
                self.ln()
                continue

            # ── Multiline row: measure exact row height first ──
            x_start = self.get_x()
            y_start = self.get_y()
            row_h = line_h

            for i, (val, w) in enumerate(zip(row, cws)):
                if i in ml_cols:
                    text = display_or_na(normalize_wrap_text(val))
                    # dry_run returns the resulting line list for this width/font
                    wrapped_lines = self.multi_cell(
                        w,
                        line_h,
                        text,
                        dry_run=True,
                        output="LINES"
                    )
                    wrapped_count = max(1, len(wrapped_lines))
                    row_h = max(row_h, wrapped_count * line_h)

            # Force page break before drawing the full row (avoid row splitting)
            if y_start + row_h > page_bottom:
                self.add_page()
                x_start = self.get_x()
                y_start = self.get_y()

            # Draw each cell using the computed row height
            for i, (val, w) in enumerate(zip(row, cws)):
                cell_x = x_start + sum(cws[:i])
                self.set_xy(cell_x, y_start)

                # Full border/background first
                self._c(_C_WHITE, fill=True)
                self._c(_C_BORDER, draw=True)
                self.rect(cell_x, y_start, w, row_h, style="FD")

                if i in ml_cols:
                    text = display_or_na(normalize_wrap_text(val))
                    self.set_xy(cell_x, y_start)
                    self.multi_cell(
                        w,
                        line_h,
                        text,
                        border=0,
                        fill=False,
                        new_x="LEFT",
                        new_y="NEXT"
                    )
                else:
                    safe = str(val).replace("\r", " ").replace("\n", " ")
                    safe = display_or_na(safe)
                    self.set_xy(cell_x, y_start)
                    self.cell(w, row_h, safe, border=0, fill=False, align="C")

            # Advance cursor past the row
            self.set_xy(x_start, y_start + row_h)

        self.ln(2)

    def render_patient(self, pet, customer):
        LW = 38                            # label column width
        VW = (self.pw / 2) - LW           # value column width (half page)

        def kv2(l1, v1, l2="", v2=""):
            """Two label-value pairs side-by-side."""
            self._c(_C_ROW_HEAD, fill=True)
            self._c(_C_BORDER, draw=True)
            self.set_line_width(0.2)
            self.set_dash_pattern()
            self.set_font("Thai", "B", 10)
            self.cell(LW, 7, l1, border=1, fill=True)
            self.set_font("Thai", "", 10)
            self._c(_C_LIGHT_BLUE, fill=True)
            self.cell(VW, 7, str(v1)[:40], border=1, fill=True)
            if l2:
                self.set_font("Thai", "B", 10)
                self._c(_C_ROW_HEAD, fill=True)
                self.cell(LW, 7, l2, border=1, fill=True)
                self.set_font("Thai", "", 10)
                self._c(_C_LIGHT_BLUE, fill=True)
                self.cell(VW, 7, str(v2)[:40], border=1, fill=True)
            self.ln()

        def kv_full(label, value):
            """One label spanning full width with value."""
            self._c(_C_ROW_HEAD, fill=True)
            self._c(_C_BORDER, draw=True)
            self.set_line_width(0.2)
            self.set_dash_pattern()

            y_start = self.get_y()
            x_start = self.get_x()
            value_w = self.pw - LW
            # Collapse newlines to spaces so they never hit the glyph renderer
            value_str = str(value).replace("\r", " ").replace("\n", " ")

            # ── Step 1: Draw value multi_cell first to let it expand ──
            self.set_font("Thai", "", 10)
            self._c(_C_LIGHT_BLUE, fill=True)
            self.set_xy(x_start + LW, y_start)
            self.multi_cell(value_w, 7, value_str, border=1, fill=True)
            y_end = self.get_y()

            # ── Step 2: Go back and draw label with exact measured height ──
            label_h = y_end - y_start
            self.set_xy(x_start, y_start)
            self.set_font("Thai", "B", 10)
            self._c(_C_ROW_HEAD, fill=True)
            self.cell(LW, label_h, label, border=1, fill=True, align="L")

            # ── Step 3: Restore cursor to below the row ──
            self.set_xy(x_start, y_end)



        self.doc_title("เวชระเบียนสัตว์ป่วย  —  Medical Record")
        self.section_banner("ข้อมูลผู้ป่วย / Patient Information")

        age_parts = []
        if pet.get("petageyear"):
            age_parts.append(f"{pet['petageyear']} ปี")
        if pet.get("petagemonth"):
            age_parts.append(f"{pet['petagemonth']} เดือน")
        if pet.get("petageday"):
            age_parts.append(f"{pet['petageday']} วัน")
        age_str = " ".join(age_parts) or txt(pet.get("petbirthday")) or "-"

        kv2("รหัสสัตว์ป่วย",  txt(pet.get("petid"))    or "-",
            "ชื่อสัตว์",       txt(pet.get("petname"))  or "-")
        kv2("ชนิด",            txt(pet.get("pettype"))  or "-",
            "พันธุ์",           txt(pet.get("petbreed")) or "-")
        kv2("เพศ",             txt(pet.get("petsex"))   or "-",
            "อายุ",             age_str)

        if customer:
            owner = " ".join(filter(None, [
                txt(customer.get("title")),
                txt(customer.get("firstname")),
                txt(customer.get("lastname")),
            ])) or "-"
            phones = ", ".join(filter(None, [
                txt(customer.get("tel_1")),
                txt(customer.get("mobile_1")),
            ])) or "-"
            addr_parts = list(filter(None, [
                txt(customer.get("address")),
                ("ซ." + txt(customer.get("soi")))  if customer.get("soi")  else "",
                ("ถ." + txt(customer.get("road"))) if customer.get("road") else "",
                txt(customer.get("tumbon")),
                txt(customer.get("ampor")),
                txt(customer.get("province")),
                txt(customer.get("zipcode")),
            ]))
            kv2("เจ้าของ", owner, "โทรศัพท์", phones)
            kv_full("ที่อยู่", " ".join(addr_parts) or "-")

        if pet.get("petnote"):
            kv_full("หมายเหตุ", txt(pet.get("petnote")))

        self.ln(4)

    def render_opd(self, idx, opd, pe, vaccines, prognoses, treatments, labs):
        date_str = fmt_dt(opd.get("opd_datetime"))
        doctor   = txt(opd.get("doctor_name")) or "-"
        opd_id   = opd["opd_id"]
        vitals   = "  ".join(filter(None, [
            f"T:{opd['opd_T']}C"            if opd.get("opd_T")           else "",
            f"BW:{opd['opd_weight_kg']}kg"  if opd.get("opd_weight_kg")   else "",
            f"Pain:{opd['opd_pain_score']}"  if opd.get("opd_pain_score")  else "",
        ]))

        # OPD header bar
        self.set_font("Thai", "B", 11)
        self._c(_C_DARK_BLUE, fill=True)
        self._c(_C_WHITE, text=True)
        self.cell(self.pw, 9,
                  f"OPD {idx}  |  #{opd_id}  |  {date_str}  |  {doctor}",
                  fill=True, new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        if vitals:
            self.set_font("Thai", "", 9)
            self._c(_C_ROW_HEAD, fill=True)
            self.cell(self.pw, 6, "  " + vitals, fill=True,
                      new_x="LMARGIN", new_y="NEXT")
        self.ln(2)

        # 1. Physical Exam
        self.sub_label("1. การตรวจร่างกาย (Physical Exam)")
        self.render_vitals(pe)

        # 2. Vaccine History
        self.sub_label("2. ประวัติการฉีดวัคซีน (Vaccine History)")
        self.render_table(
            ["ชื่อวัคซีน", "รายละเอียด", "วันที่", "สถานะ"],
            [
                (
                    rich_txt(v.get("vaccine_name") or v.get("content")) or "-",
                    rich_txt(v.get("content")),
                    fmt_dt(v.get("timestamp")),
                    "ใช้งาน" if v.get("status") == 1 else "-",
                )
                for v in vaccines
            ],
            col_widths=[self.pw * 0.40, self.pw * 0.24,
                        self.pw * 0.21, self.pw * 0.15],
        )

        # 3. Prognosis
        self.sub_label("3. การพยากรณ์โรค (Prognosis)")
        self.render_table(
            ["การพยากรณ์โรค", "วันที่"],
            [(txt(p["content"]), fmt_dt(p["timestamp"])) for p in prognoses],
            col_widths=[self.pw * 0.72, self.pw * 0.28],
        )

        # 4. Treatment Plan
        self.sub_label("4. แผนการรักษา (Treatment Plan)")
        self.render_table(
            ["แผนการรักษา", "วันที่"],
            [(rich_txt(t["content"]), fmt_dt(t["timestamp"])) for t in treatments],
            col_widths=[self.pw * 0.72, self.pw * 0.28],
            multiline_cols={0},   # ← col 0 wraps
        )

        # 5. Reporting Symptoms
        self.sub_label("5. อาการที่รายงาน / Reporting Symptoms")
        self.text_block(rich_txt(opd.get("opd_cc")))

        # 6. Lab / LIS
        self.sub_label("6. รายงาน Lab / LIS")
        self.render_table(
            ["รายการ Lab / LIS", "วันที่", "สถานะ"],
            [
                (rich_txt(l.get("product")),
                 fmt_dt(l.get("timestamp")),
                 txt(l.get("lab_status")))
                for l in labs
            ],
            col_widths=[self.pw * 0.60, self.pw * 0.28, self.pw * 0.12],
        )
        if rich_txt(opd.get("reportlab")):
            self.text_block(rich_txt(opd.get("reportlab")))

        # 7. Vaccine Allergy Observation
        self.sub_label("7. สังเกตอาการแพ้วัคซีน (Vaccine Allergy Observation)")
        self.text_block(rich_txt(opd.get("suggestion")))
        self.ln(3)

    def render_admit(self, idx, ah, labs, body_rows, eat_rows,
                     general_rows, other_rows, plan_rows, talk_rows, treatment_rows):
        ahid      = ah["admit_history_id"]
        since     = fmt_dt(ah.get("admit_since_date"))
        to        = fmt_dt(ah.get("admit_to_date")) or "-"
        status    = txt(ah.get("admit_status_name") or ah.get("admit_status_text")) or "-"

        # Admit header bar
        self.set_font("Thai", "B", 11)
        self._c(_C_DARK_BLUE, fill=True)
        self._c(_C_WHITE, text=True)
        self.cell(self.pw, 9,
                  f"Admit {idx}  |  #{ahid}  |  {since} -> {to}  |  {status}",
                  fill=True, new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        self.ln(2)

        # History / Physical / Differential / Final
        for label, field in [
            ("ประวัติ (History)",               rich_txt(ah.get("history"))),
            ("การตรวจร่างกาย (Physical)",        rich_txt(ah.get("physical"))),
            ("Differential Diagnosis",           rich_txt(ah.get("differential"))),
            ("Final Diagnosis",                  rich_txt(ah.get("final"))),
            ("การพยากรณ์โรค (Prognosis)",        rich_txt(ah.get("prognosis"))),
        ]:
            if field and field.strip():
                self.sub_label(label)
                self.text_block(field.strip())

        # 1. Lab
        self.sub_label("1. รายงาน Lab / LIS")
        self.render_table(
            ["รายการ Lab / LIS", "วันที่", "สถานะ"],
                        [(rich_txt(l.get("product")), fmt_dt(l.get("timestamp")),
              txt(l.get("lab_status"))) for l in labs],
            col_widths=[self.pw * 0.60, self.pw * 0.28, self.pw * 0.12],
        )
        if rich_txt(ah.get("reportlab")):
            self.text_block(rich_txt(ah.get("reportlab")))

        # 2. Monitor: Body vitals
        self.sub_label("2. ติดตามสัญญาณชีพ (Body Monitor)")
        self.render_table(
            ["เวลา", "T", "HR", "RR", "BP", "MM", "CRT", "UOP", "ผู้ดูแล"],
            [
                (
                    rich_txt(r.get("monitor_body_f_time") or r.get("timestamp")),
                    rich_txt(r.get("monitor_body_f")),
                    rich_txt(r.get("monitor_body_hr")),
                    rich_txt(r.get("monitor_body_rr")),
                    rich_txt(r.get("monitor_body_bp")),
                    rich_txt(r.get("monitor_body_mm")),
                    rich_txt(r.get("monitor_body_crt")),
                    rich_txt(r.get("monitor_body_uop")),
                    rich_txt(r.get("veterinary")),
                )
                for r in body_rows
            ],
            col_widths=[self.pw*0.10, self.pw*0.07, self.pw*0.07, self.pw*0.07,
                        self.pw*0.10, self.pw*0.07, self.pw*0.07, self.pw*0.10,
                        self.pw*0.35],
                        multiline_cols={1}
        )

        # 3. Monitor: Eat
        self.sub_label("3. บันทึกการกินอาหาร (Eat Monitor)")
        self.render_table(
            ["เวลา", "ประเภทอาหาร", "ปริมาณ", "หมายเหตุ", "ผู้ดูแล"],
            [
                (
                    rich_txt(r.get("monitor_eat_time")),
                    rich_txt(r.get("monitor_eat_type")),
                    rich_txt(r.get("monitor_eat_isme")),
                    rich_txt(r.get("monitor_eat_cc")),
                    rich_txt(r.get("veterinary")),
                )
                for r in eat_rows
            ],
            col_widths=[self.pw*0.10, self.pw*0.24, self.pw*0.15,
                        self.pw*0.31, self.pw*0.20],
                        multiline_cols={1}
        )

        # 4. Monitor: General
        self.sub_label("4. สังเกตอาการทั่วไป (General Monitor)")
        self.render_table(
            ["เวลา", "ปัสสาวะ", "อาเจียน", "อื่นๆ", "ไอ", "หมดสติ", "ผู้ดูแล"],
            [
                (
                    txt(r.get("monitor_general_urine_time")),
                    f"{rich_txt(r.get('monitor_general_urine'))} {rich_txt(r.get('monitor_general_urine_cc'))}".strip(),
                    f"{rich_txt(r.get('monitor_general_vomit'))} {rich_txt(r.get('monitor_general_vomit_cc'))}".strip(),
                    f"{rich_txt(r.get('monitor_general_oh'))} {rich_txt(r.get('monitor_general_oh_cc'))}".strip(),
                    rich_txt(r.get("monitor_general_cough")),
                    txt(r.get("monitor_general_coma")),
                    txt(r.get("veterinary")),
                )
                for r in general_rows
            ],
            col_widths=[self.pw*0.09, self.pw*0.15, self.pw*0.14, self.pw*0.14,
                        self.pw*0.09, self.pw*0.14, self.pw*0.25],
                        multiline_cols={1}
        )

        # 5. Monitor: Other
        self.sub_label("5. บันทึกอื่นๆ (Other Monitor)")
        self.render_table(
            ["เวลา", "รายละเอียด", "ผู้ดูแล"],
            [
                (txt(r.get("monitor_other_time")),
                 rich_txt(r.get("monitor_other_content")),
                 txt(r.get("veterinary")))
                for r in other_rows
            ],
            col_widths=[self.pw*0.12, self.pw*0.63, self.pw*0.25],
            multiline_cols={1}
        )

        # 6. Monitor: Plan
        self.sub_label("6. แผนการดูแล (Monitor Plan)")
        self.render_table(
            ["ช่วงเวลา", "แผนการดูแล", "ผู้ดูแล"],
            [
                (
                    f"{rich_txt(r.get('monitor_plan_time_set1'))}-{rich_txt(r.get('monitor_plan_time_set2'))}",
                    rich_txt(r.get("monitor_plan_content")),
                    rich_txt(r.get("veterinary")),
                )
                for r in plan_rows
            ],
            col_widths=[self.pw*0.18, self.pw*0.57, self.pw*0.25],
            multiline_cols={1}
        )

        # 7. Monitor: Talk
        self.sub_label("7. บันทึกการสื่อสาร (Talk / Communication)")
        self.render_table(
            ["เวลา", "รายละเอียด", "ผู้ดูแล"],
            [
                (rich_txt(r.get("monitor_talk_time")),
                 rich_txt(r.get("monitor_talk_content")),
                 rich_txt(r.get("veterinary")))
                for r in talk_rows
            ],
            col_widths=[self.pw*0.12, self.pw*0.63, self.pw*0.25],
            multiline_cols={1}
        )

        # 8. Monitor: Treatment
        self.sub_label("8. บันทึกการรักษา (Treatment Monitor)")
        self.render_table(
            ["เวลา", "รายละเอียด", "ผู้ดูแล"],
            [
                (rich_txt(r.get("monitor_other_time")),
                 rich_txt(r.get("monitor_other_content")),
                 rich_txt(r.get("veterinary")))
                for r in treatment_rows
            ],
            col_widths=[self.pw*0.12, self.pw*0.63, self.pw*0.25],
            multiline_cols={1}
        )

        # Suggestion / discharge notes
        if rich_txt(ah.get("suggestion")):
            self.sub_label("คำแนะนำ / Discharge Notes")
            self.text_block(rich_txt(ah.get("suggestion")))

        self.ln(3)


# ---------------------------------------------------------------------------
# Per-pet PDF generation
# ---------------------------------------------------------------------------

def generate_pdf_for_pet(conn, pet):
    pet_uid  = pet["pet_uid"]
    petid    = txt(pet.get("petid")) or str(pet_uid)
    customer = get_customer(conn, pet["cuid"]) if pet.get("cuid") else None
    opds     = get_opds(conn, pet_uid)

    if not opds:
        print(f"  [skip] {petid} -- no OPD records")
        return

    pdf = MedicalPDF()
    pdf.add_page()
    pdf.render_patient(pet, customer)

    for idx, opd in enumerate(opds, start=1):
        pe         = get_physical_exam(conn, opd["queue_uid"]) if opd.get("queue_uid") else None
        vaccines   = get_vaccines(conn, opd["opd_id"])
        prognoses  = get_prognosis(conn, opd["opd_id"])
        treatments = get_treatment(conn, opd["opd_id"])
        labs       = get_labs(conn, opd["opd_id"])
        pdf.render_opd(idx, opd, pe, vaccines, prognoses, treatments, labs)

    # Admit histories
    admits = get_admit_histories(conn, pet_uid)
    if admits:
        pdf.add_page()
        pdf.section_banner("ประวัติการ Admit / Hospitalization Records")
        pdf.ln(2)
        for aidx, ah in enumerate(admits, start=1):
            ahid = ah["admit_history_id"]
            pdf.render_admit(
                aidx, ah,
                labs          = get_admit_labs(conn, ahid),
                body_rows     = get_admit_monitor_body(conn, ahid),
                eat_rows      = get_admit_monitor_eat(conn, ahid),
                general_rows  = get_admit_monitor_general(conn, ahid),
                other_rows    = get_admit_monitor_other(conn, ahid),
                plan_rows     = get_admit_monitor_plan(conn, ahid),
                talk_rows     = get_admit_monitor_talk(conn, ahid),
                treatment_rows= get_admit_monitor_treatment(conn, ahid),
            )

    # Footer note
    pdf.set_font("Thai", "", 8)
    pdf.set_text_color(*_C_GREY)
    pdf.cell(pdf.pw, 5,
             f"สร้างเมื่อ {datetime.now().strftime('%d/%m/%Y %H:%M')}  |  {petid}",
             align="R", new_x="LMARGIN", new_y="NEXT")
    pdf.set_text_color(*_C_BLACK)

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    safe_id  = "".join(c for c in petid if c.isalnum() or c in "-_")
    out_path = os.path.join(OUTPUT_DIR, f"medical_record_{safe_id}.pdf")
    pdf.output(out_path)
    admit_count = len(get_admit_histories(conn, pet_uid))
    print(f"  [done] {petid} -- {len(opds)} OPD(s), {admit_count} Admit(s) -> {out_path}")


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main():
    print("Connecting to database...")
    conn = get_connection()
    try:
        print("Fetching last 10 pets with OPD activity...")
        pets = get_last_10_pets(conn)
        print(f"Found {len(pets)} pet(s). Generating PDFs...\n")
        for pet in pets:
            generate_pdf_for_pet(conn, pet)
        print("\nAll done.")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
