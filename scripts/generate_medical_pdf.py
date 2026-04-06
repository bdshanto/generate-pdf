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

def decode_blob(val):
    if isinstance(val, (bytes, bytearray)):
        try:
            return val.decode("utf-8")
        except Exception:
            return ""
    return val or ""


def txt(val):
    s = str(decode_blob(val)).strip() if val is not None else ""
    return s.replace("\r", " ").replace("\n", " ")


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
        return re.sub(r"\s+", " ", " ".join(self._parts)).strip()


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
            "pet_hr, pet_rr, pet_bcs, pet_mm, pet_crt, hydration "
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
        self.cell(self.pw, 5, "ไม่มีข้อมูล", new_x="LMARGIN", new_y="NEXT")
        self._c(_C_BLACK, text=True)
        self.ln(1)

    def text_block(self, text, size=10):
        t = str(text).strip() if text else ""
        if not t:
            self.empty_row()
            return
        self.set_font("Thai", "", size)
        self.multi_cell(self.pw, 5.5, t)
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
        note = strip_html(pe.get("more_info"))
        if note:
            self.ln(1)
            self.text_block(note)
        else:
            self.ln(1)

    def render_table(self, headers, rows, col_widths=None):
        if not rows:
            self.empty_row()
            return
        n = len(headers)
        cws = col_widths or [self.pw / n] * n
        # header row
        self._c(_C_ROW_HEAD, fill=True)
        self._c(_C_BORDER, draw=True)
        self.set_line_width(0.2)
        self.set_dash_pattern()
        self.set_font("Thai", "B", 9)
        for h, w in zip(headers, cws):
            self.cell(w, 7, h, border=1, fill=True)
        self.ln()
        # data rows
        self.set_font("Thai", "", 9)
        self._c(_C_WHITE, fill=True)
        for row in rows:
            for val, w in zip(row, cws):
                self.cell(w, 6, str(val)[:90], border=1, fill=True)
            self.ln()
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
            self.set_font("Thai", "B", 10)
            self.cell(LW, 7, label, border=1, fill=True)
            self.set_font("Thai", "", 10)
            self._c(_C_LIGHT_BLUE, fill=True)
            self.cell(self.pw - LW, 7, str(value)[:100], border=1, fill=True)
            self.ln()

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
                    txt(v.get("vaccine_name") or v.get("content")) or "-",
                    txt(v.get("content")),
                    fmt_dt(v.get("timestamp")),
                    "ใช้งาน" if v.get("status") == 1 else "-",
                )
                for v in vaccines
            ],
            col_widths=[self.pw * 0.30, self.pw * 0.34,
                        self.pw * 0.24, self.pw * 0.12],
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
            [(strip_html(t["content"]), fmt_dt(t["timestamp"])) for t in treatments],
            col_widths=[self.pw * 0.72, self.pw * 0.28],
        )

        # 5. Reporting Symptoms
        self.sub_label("5. อาการที่รายงาน / Reporting Symptoms")
        self.text_block(strip_html(opd.get("opd_cc")))

        # 6. Lab / LIS
        self.sub_label("6. รายงาน Lab / LIS")
        self.render_table(
            ["รายการ Lab / LIS", "วันที่", "สถานะ"],
            [
                (strip_html(l.get("product")),
                 fmt_dt(l.get("timestamp")),
                 txt(l.get("lab_status")))
                for l in labs
            ],
            col_widths=[self.pw * 0.60, self.pw * 0.28, self.pw * 0.12],
        )
        if strip_html(opd.get("reportlab")):
            self.text_block(strip_html(opd.get("reportlab")))

        # 7. Vaccine Allergy Observation
        self.sub_label("7. สังเกตอาการแพ้วัคซีน (Vaccine Allergy Observation)")
        self.text_block(strip_html(opd.get("suggestion")))
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
    print(f"  [done] {petid} -- {len(opds)} OPD(s) -> {out_path}")


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
