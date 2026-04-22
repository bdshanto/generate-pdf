"""
MySQL -> MSSQL flat migration.

Reads ALL pets with OPD or Admit activity from MySQL and upserts into two flat tables:
  - dbo.OLD_OPD_FLAT  (one row per OPD visit,  PK = opd_id)
  - dbo.OLD_IPD_FLAT  (one row per Admit,       PK = admit_history_id)

Sub-tables (vaccines, labs, monitor logs, etc.) are stored as JSON columns
and are queryable in MSSQL 2016+ via OPENJSON().

Usage:
    python -m scripts.migrate_to_mssql

Requirements:
    pip install pyodbc
    ODBC Driver 17 (or 18) for SQL Server must be installed on this machine.
    Add MSSQL_HOST / MSSQL_USER / MSSQL_PASSWORD / MSSQL_DB to your .env file.
"""

import json
import re
from datetime import datetime, date
from html.parser import HTMLParser

import pymysql
import pymysql.cursors
import pyodbc

from config.settings import (
    DB_HOST, DB_USER, DB_PASSWORD, DB_NAME,
    MSSQL_HOST, MSSQL_USER, MSSQL_PASSWORD, MSSQL_DB, MSSQL_DRIVER,
)

# ---------------------------------------------------------------------------
# Text helpers (self-contained — no fpdf dependency)
# ---------------------------------------------------------------------------

def decode_blob(val):
    if isinstance(val, (bytes, bytearray)):
        try:
            return val.decode("utf-8")
        except Exception:
            return ""
    return val or ""


def _plain(val):
    """Flat plain text — decode blob, strip, collapse all whitespace."""
    s = str(decode_blob(val)).strip() if val is not None else ""
    return re.sub(r"\s+", " ", s).strip() or None


def fmt_dt(val):
    """Return a SQL-safe date/datetime value, or None for invalid inputs."""
    if val is None:
        return None
    if isinstance(val, (datetime, date)):
        return val

    s = str(val).strip()
    if not s:
        return None

    # Common MySQL zero-date placeholders that MSSQL cannot convert.
    if s.startswith("0000-00-00"):
        return None

    # Try Python ISO parser first.
    try:
        return datetime.fromisoformat(s.replace("Z", "+00:00"))
    except Exception:
        pass

    # Fallback accepted patterns from mixed legacy data.
    for pattern in (
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d %H:%M:%S.%f",
        "%Y-%m-%d",
        "%d/%m/%Y %H:%M",
        "%d/%m/%Y",
    ):
        try:
            return datetime.strptime(s, pattern)
        except ValueError:
            continue

    return None


class _RichHTMLParser(HTMLParser):
    _BLOCK = {"p", "div", "h1", "h2", "h3", "h4", "h5", "h6",
              "tr", "blockquote", "ul", "ol"}

    def __init__(self):
        super().__init__()
        self._parts = []

    def handle_starttag(self, tag, attrs):
        if tag == "br":
            self._parts.append("\n")
        elif tag == "li":
            self._parts.append("\n- ")
        elif tag in self._BLOCK:
            self._parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self._BLOCK or tag == "li":
            self._parts.append("\n")

    def handle_data(self, data):
        self._parts.append(data)

    def handle_entityref(self, name):
        import html as _html
        self._parts.append(_html.unescape(f"&{name};"))

    def handle_charref(self, name):
        import html as _html
        self._parts.append(_html.unescape(f"&#{name};"))

    def result(self):
        raw = "".join(self._parts)
        lines = [ln.strip() for ln in raw.split("\n") if ln.strip()]
        return "\n".join(lines)


def rich_txt(val):
    """Strip CKEditor HTML to structured plain text. Returns None if empty."""
    raw = decode_blob(val)
    if not raw:
        return None
    try:
        p = _RichHTMLParser()
        p.feed(raw)
        result = p.result().strip()
        return result or None
    except Exception:
        s = re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", raw)).strip()
        return s or None


def to_json(rows):
    """
    Serialize a list of MySQL DictCursor rows to a compact JSON string.
    datetime/date -> ISO string, bytes -> utf-8 string.
    Returns '[]' for empty lists.
    """
    def _clean(row):
        out = {}
        for k, v in row.items():
            if isinstance(v, (datetime, date)):
                out[k] = v.isoformat()
            elif isinstance(v, (bytes, bytearray)):
                out[k] = decode_blob(v)
            else:
                out[k] = v
        return out
    return json.dumps([_clean(r) for r in rows], ensure_ascii=False)


# ---------------------------------------------------------------------------
# MySQL connection + readers
# ---------------------------------------------------------------------------

def mysql_connect():
    return pymysql.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASSWORD, db=DB_NAME,
        charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor,
    )


def get_all_pets(conn):
    """All pets that have at least one active OPD or any Admit record."""
    sql = """
        SELECT DISTINCT
               p.uid AS pet_uid, p.petid, p.petname, p.pettype, p.petbreed,
               p.petsex, p.petbirthday, p.petageyear, p.petagemonth,
               p.petageday, p.petnote, p.cuid
        FROM pet p
        WHERE EXISTS (
                SELECT 1 FROM opd o
                WHERE o.pet_uid = p.uid AND o.opd_status = 1
              )
           OR EXISTS (
                SELECT 1 FROM admit_history ah
                WHERE ah.pet_uid = p.uid
              )
        ORDER BY p.uid
    """
    with conn.cursor() as c:
        c.execute(sql)
        return c.fetchall()


def get_customer(conn, cuid):
    with conn.cursor() as c:
        c.execute(
            "SELECT title, firstname, lastname, tel_1, mobile_1, "
            "address, soi, road, tumbon, ampor, province, zipcode "
            "FROM customer WHERE uid = %s", (cuid,))
        return c.fetchone()


def get_opds(conn, pet_uid):
    with conn.cursor() as c:
        c.execute(
            "SELECT opd_id, queue_uid, opd_datetime, doctor_name, "
            "opd_T, opd_P, opd_R, opd_weight_kg, opd_pain_score, "
            "opd_cc, suggestion, reportlab "
            "FROM opd WHERE pet_uid = %s AND opd_status = 1 "
            "ORDER BY opd_datetime", (pet_uid,))
        return c.fetchall()


def get_physical_exam(conn, queue_uid):
    with conn.cursor() as c:
        c.execute(
            "SELECT more_info, pet_weight, pet_temperature, pet_bp, "
            "pet_hr, pet_rr, pet_bcs, pet_mm, pet_crt, hydration, "
            "content, treatment, comment "
            "FROM queue_history WHERE queue_uid = %s", (queue_uid,))
        return c.fetchone()


def get_vaccines(conn, opd_id):
    with conn.cursor() as c:
        c.execute(
            "SELECT s.stock_name AS vaccine_name, ov.content, ov.status, ov.timestamp "
            "FROM opd_vaccine ov LEFT JOIN stock s ON s.uid = ov.stock_uid "
            "WHERE ov.opd_id = %s ORDER BY ov.timestamp", (opd_id,))
        return c.fetchall()


def get_prognosis(conn, opd_id):
    with conn.cursor() as c:
        c.execute(
            "SELECT content, timestamp FROM opd_prognosis "
            "WHERE opd_id = %s ORDER BY timestamp", (opd_id,))
        return c.fetchall()


def get_treatment(conn, opd_id):
    with conn.cursor() as c:
        c.execute(
            "SELECT content, timestamp FROM opd_treatment "
            "WHERE opd_id = %s ORDER BY timestamp", (opd_id,))
        return c.fetchall()


def get_labs(conn, opd_id):
    with conn.cursor() as c:
        c.execute(
            "SELECT product, timestamp, lab_status "
            "FROM opd_lab WHERE opd_id = %s AND status = 1 "
            "ORDER BY timestamp", (opd_id,))
        return c.fetchall()


def get_admit_histories(conn, pet_uid):
    with conn.cursor() as c:
        c.execute(
            "SELECT ah.admit_history_id, ah.admit_since_date, ah.admit_to_date, "
            "ah.admit_status, ast.admit_status_name, ah.doctor_id, u.name AS doctor_name, "
            "ah.history, ah.physical, ah.differential, ah.final, "
            "ah.prognosis, ah.suggestion, ah.reportlab, ah.admit_status_text "
            "FROM admit_history ah "
            "LEFT JOIN admit_status ast ON ast.admit_status_id = ah.admit_status "
            "LEFT JOIN `user` u ON u.user_id = ah.doctor_id "
            "WHERE ah.pet_uid = %s ORDER BY ah.admit_since_date", (pet_uid,))
        return c.fetchall()


def get_admit_labs(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT product, timestamp, lab_status FROM admit_lab "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_body(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_body_f_time, monitor_body_f, "
            "monitor_body_hr_time, monitor_body_hr, "
            "monitor_body_rr_time, monitor_body_rr, "
            "monitor_body_bp_time, monitor_body_bp, "
            "monitor_body_mm_time, monitor_body_mm, "
            "monitor_body_crt_time, monitor_body_crt, "
            "monitor_body_uop_time, monitor_body_uop, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_body "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_eat(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_eat_time, monitor_eat_type, monitor_eat_isme, "
            "monitor_eat_cc, veterinary, assistant, timestamp "
            "FROM admit_monitor_eat "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_general(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_general_urine_time, monitor_general_urine, monitor_general_urine_cc, "
            "monitor_general_vomit_time, monitor_general_vomit, monitor_general_vomit_cc, "
            "monitor_general_oh_time, monitor_general_oh, monitor_general_oh_cc, "
            "monitor_general_cough_time, monitor_general_cough, "
            "monitor_general_coma_time, monitor_general_coma, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_general "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_other(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_other_time, monitor_other_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_other "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_plan(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_plan_time_set1, monitor_plan_time_set2, "
            "monitor_plan_content, veterinary, assistant, timestamp "
            "FROM admit_monitor_plan "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_talk(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_talk_time, monitor_talk_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_talk "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


def get_admit_monitor_treatment(conn, ahid):
    with conn.cursor() as c:
        c.execute(
            "SELECT monitor_other_time, monitor_other_content, "
            "veterinary, assistant, timestamp "
            "FROM admit_monitor_treatment "
            "WHERE admit_history_id = %s AND status = 1 ORDER BY timestamp", (ahid,))
        return c.fetchall()


# ---------------------------------------------------------------------------
# MSSQL connection + DDL
# ---------------------------------------------------------------------------

def _mssql_conn_str(database):
    import os

    use_windows_auth = os.getenv("MSSQL_AUTH", "").lower() == "windows"
    if use_windows_auth:
        return (
            f"DRIVER={{{MSSQL_DRIVER}}};"
            f"SERVER={MSSQL_HOST};"
            f"DATABASE={database};"
            "Trusted_Connection=yes;"
            "TrustServerCertificate=yes;"
        )

    return (
        f"DRIVER={{{MSSQL_DRIVER}}};"
        f"SERVER={MSSQL_HOST};"
        f"DATABASE={database};"
        f"UID={MSSQL_USER};"
        f"PWD={MSSQL_PASSWORD};"
        "TrustServerCertificate=yes;"
    )


def ensure_mssql_database():
    """Connect to master and create destination DB if it does not exist."""
    master_conn = pyodbc.connect(_mssql_conn_str("master"), autocommit=True)
    try:
        safe_db = (MSSQL_DB or "").replace("]", "]]" )
        if not safe_db:
            raise ValueError("MSSQL_DB is empty. Please set MSSQL_DB in your .env")

        cur = master_conn.cursor()
        cur.execute(f"IF DB_ID(N'{safe_db}') IS NULL CREATE DATABASE [{safe_db}];")
    finally:
        master_conn.close()


def mssql_connect():
    return pyodbc.connect(_mssql_conn_str(MSSQL_DB), autocommit=False)


_DDL_OPD_FLAT = """
IF OBJECT_ID('dbo.OLD_OPD_FLAT', 'U') IS NULL
CREATE TABLE dbo.OLD_OPD_FLAT (
    -- Primary key (source: opd.opd_id)
    opd_id              INT             NOT NULL CONSTRAINT PK_OLD_OPD_FLAT PRIMARY KEY,

    -- Pet identity (source: pet)
    pet_uid             INT             NULL,
    petid               NVARCHAR(50)    NULL,
    petname             NVARCHAR(100)   NULL,
    pettype             NVARCHAR(50)    NULL,
    petbreed            NVARCHAR(100)   NULL,
    petsex              NVARCHAR(20)    NULL,
    petbirthday         DATE            NULL,

    -- Owner (source: customer)
    owner_name          NVARCHAR(200)   NULL,
    owner_phone         NVARCHAR(100)   NULL,
    owner_address       NVARCHAR(500)   NULL,

    -- Visit header (source: opd)
    opd_datetime        DATETIME        NULL,
    doctor_name         NVARCHAR(200)   NULL,

    -- OPD vitals (source: opd)
    opd_temperature     NVARCHAR(20)    NULL,
    opd_pulse           NVARCHAR(20)    NULL,
    opd_respiration     NVARCHAR(20)    NULL,
    opd_weight_kg       NVARCHAR(20)    NULL,
    opd_pain_score      NVARCHAR(10)    NULL,

    -- Narratives, HTML-stripped (source: opd)
    chief_complaint     NVARCHAR(MAX)   NULL,
    suggestion          NVARCHAR(MAX)   NULL,
    reportlab           NVARCHAR(MAX)   NULL,

    -- Physical exam vitals (source: queue_history)
    pe_weight           NVARCHAR(20)    NULL,
    pe_temperature      NVARCHAR(20)    NULL,
    pe_bp               NVARCHAR(30)    NULL,
    pe_hr               NVARCHAR(20)    NULL,
    pe_rr               NVARCHAR(20)    NULL,
    pe_bcs              NVARCHAR(20)    NULL,
    pe_mm               NVARCHAR(50)    NULL,
    pe_crt              NVARCHAR(20)    NULL,
    pe_hydration        NVARCHAR(50)    NULL,
    pe_more_info        NVARCHAR(MAX)   NULL,
    pe_content          NVARCHAR(MAX)   NULL,
    pe_treatment        NVARCHAR(MAX)   NULL,
    pe_comment          NVARCHAR(MAX)   NULL,

    -- Sub-tables as JSON arrays (OPENJSON-queryable)
    -- source: opd_vaccine JOIN stock
    vaccines_json       NVARCHAR(MAX)   NULL,
    -- source: opd_prognosis
    prognoses_json      NVARCHAR(MAX)   NULL,
    -- source: opd_treatment
    treatments_json     NVARCHAR(MAX)   NULL,
    -- source: opd_lab
    labs_json           NVARCHAR(MAX)   NULL,

    migrated_at         DATETIME        NOT NULL CONSTRAINT DF_OLD_OPD_FLAT_migrated DEFAULT GETDATE()
);
"""

_DDL_IPD_FLAT = """
IF OBJECT_ID('dbo.OLD_IPD_FLAT', 'U') IS NULL
CREATE TABLE dbo.OLD_IPD_FLAT (
    -- Primary key (source: admit_history.admit_history_id)
    admit_history_id        INT             NOT NULL CONSTRAINT PK_OLD_IPD_FLAT PRIMARY KEY,

    -- Pet identity (source: pet)
    pet_uid                 INT             NULL,
    petid                   NVARCHAR(50)    NULL,
    petname                 NVARCHAR(100)   NULL,
    pettype                 NVARCHAR(50)    NULL,
    petbreed                NVARCHAR(100)   NULL,
    petsex                  NVARCHAR(20)    NULL,
    petbirthday             DATE            NULL,

    -- Owner (source: customer)
    owner_name              NVARCHAR(200)   NULL,
    owner_phone             NVARCHAR(100)   NULL,

    -- Admit header (source: admit_history JOIN admit_status)
    admit_since_date        DATETIME        NULL,
    admit_to_date           DATETIME        NULL,
    admit_status            NVARCHAR(100)   NULL,
    doctor_id               INT             NULL,
    doctor_name             NVARCHAR(200)   NULL,

    -- Narratives, HTML-stripped (source: admit_history)
    history                 NVARCHAR(MAX)   NULL,
    physical                NVARCHAR(MAX)   NULL,
    differential            NVARCHAR(MAX)   NULL,
    final_diagnosis         NVARCHAR(MAX)   NULL,
    prognosis               NVARCHAR(MAX)   NULL,
    suggestion              NVARCHAR(MAX)   NULL,
    reportlab               NVARCHAR(MAX)   NULL,

    -- Sub-tables as JSON arrays (OPENJSON-queryable)
    -- source: admit_lab
    labs_json               NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_body
    monitor_body_json       NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_eat
    monitor_eat_json        NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_general
    monitor_general_json    NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_other
    monitor_other_json      NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_plan
    monitor_plan_json       NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_talk
    monitor_talk_json       NVARCHAR(MAX)   NULL,
    -- source: admit_monitor_treatment
    monitor_treatment_json  NVARCHAR(MAX)   NULL,

    migrated_at             DATETIME        NOT NULL CONSTRAINT DF_OLD_IPD_FLAT_migrated DEFAULT GETDATE()
);
"""


def ensure_tables(ms_conn):
    cur = ms_conn.cursor()
    cur.execute(_DDL_OPD_FLAT)
    cur.execute(_DDL_IPD_FLAT)
    ms_conn.commit()
    print("  Tables verified / created.")


# ---------------------------------------------------------------------------
# Upsert SQL
# ---------------------------------------------------------------------------

# Column lists must stay in sync with the VALUES positions below.
# UPDATE path:  37 data params  +  1 WHERE opd_id
# INSERT path:  1 opd_id        +  37 data params
_UPSERT_OPD = """
MERGE dbo.OLD_OPD_FLAT WITH (HOLDLOCK) AS tgt
USING (SELECT ? AS opd_id) AS src ON tgt.opd_id = src.opd_id
WHEN MATCHED THEN UPDATE SET
    pet_uid=?,petid=?,petname=?,pettype=?,petbreed=?,petsex=?,petbirthday=?,
    owner_name=?,owner_phone=?,owner_address=?,
    opd_datetime=?,doctor_name=?,
    opd_temperature=?,opd_pulse=?,opd_respiration=?,opd_weight_kg=?,opd_pain_score=?,
    chief_complaint=?,suggestion=?,reportlab=?,
    pe_weight=?,pe_temperature=?,pe_bp=?,pe_hr=?,pe_rr=?,
    pe_bcs=?,pe_mm=?,pe_crt=?,pe_hydration=?,
    pe_more_info=?,pe_content=?,pe_treatment=?,pe_comment=?,
    vaccines_json=?,prognoses_json=?,treatments_json=?,labs_json=?,
    migrated_at=GETDATE()
WHEN NOT MATCHED THEN INSERT (
    opd_id,
    pet_uid,petid,petname,pettype,petbreed,petsex,petbirthday,
    owner_name,owner_phone,owner_address,
    opd_datetime,doctor_name,
    opd_temperature,opd_pulse,opd_respiration,opd_weight_kg,opd_pain_score,
    chief_complaint,suggestion,reportlab,
    pe_weight,pe_temperature,pe_bp,pe_hr,pe_rr,
    pe_bcs,pe_mm,pe_crt,pe_hydration,
    pe_more_info,pe_content,pe_treatment,pe_comment,
    vaccines_json,prognoses_json,treatments_json,labs_json
) VALUES (
    ?,
    ?,?,?,?,?,?,?,
    ?,?,?,
    ?,?,
    ?,?,?,?,?,
    ?,?,?,
    ?,?,?,?,?,
    ?,?,?,?,
    ?,?,?,?,
    ?,?,?,?
);
"""

_UPSERT_IPD = """
MERGE dbo.OLD_IPD_FLAT WITH (HOLDLOCK) AS tgt
USING (SELECT ? AS admit_history_id) AS src ON tgt.admit_history_id = src.admit_history_id
WHEN MATCHED THEN UPDATE SET
    pet_uid=?,petid=?,petname=?,pettype=?,petbreed=?,petsex=?,petbirthday=?,
    owner_name=?,owner_phone=?,
    admit_since_date=?,admit_to_date=?,admit_status=?,doctor_id=?,doctor_name=?,
    history=?,physical=?,differential=?,final_diagnosis=?,prognosis=?,
    suggestion=?,reportlab=?,
    labs_json=?,monitor_body_json=?,monitor_eat_json=?,monitor_general_json=?,
    monitor_other_json=?,monitor_plan_json=?,monitor_talk_json=?,monitor_treatment_json=?,
    migrated_at=GETDATE()
WHEN NOT MATCHED THEN INSERT (
    admit_history_id,
    pet_uid,petid,petname,pettype,petbreed,petsex,petbirthday,
    owner_name,owner_phone,
    admit_since_date,admit_to_date,admit_status,doctor_id,doctor_name,
    history,physical,differential,final_diagnosis,prognosis,
    suggestion,reportlab,
    labs_json,monitor_body_json,monitor_eat_json,monitor_general_json,
    monitor_other_json,monitor_plan_json,monitor_talk_json,monitor_treatment_json
) VALUES (
    ?,
    ?,?,?,?,?,?,?,
    ?,?,
    ?,?,?,?,?,
    ?,?,?,?,?,
    ?,?,
    ?,?,?,?,
    ?,?,?,?
);
"""


# ---------------------------------------------------------------------------
# Transform helpers
# ---------------------------------------------------------------------------

def _owner_parts(customer):
    if not customer:
        return None, None, None
    name = " ".join(filter(None, [
        _plain(customer.get("title")),
        _plain(customer.get("firstname")),
        _plain(customer.get("lastname")),
    ])) or None
    phone = ", ".join(filter(None, [
        _plain(customer.get("tel_1")),
        _plain(customer.get("mobile_1")),
    ])) or None
    addr = " ".join(filter(None, [
        _plain(customer.get("address")),
        ("ซ." + _plain(customer.get("soi")))  if customer.get("soi")  else "",
        ("ถ." + _plain(customer.get("road"))) if customer.get("road") else "",
        _plain(customer.get("tumbon")),
        _plain(customer.get("ampor")),
        _plain(customer.get("province")),
        _plain(customer.get("zipcode")),
    ])) or None
    return name, phone, addr


# ---------------------------------------------------------------------------
# Per-record migration
# ---------------------------------------------------------------------------

def migrate_opd(ms_cur, opd, pet, customer, pe, vaccines, prognoses, treatments, labs):
    owner_name, owner_phone, owner_address = _owner_parts(customer)
    pe = pe or {}
    opd_id = opd["opd_id"]

    # 37 data columns (UPDATE and INSERT share the same list)
    data = [
        pet.get("pet_uid"),
        _plain(pet.get("petid")),
        _plain(pet.get("petname")),
        _plain(pet.get("pettype")),
        _plain(pet.get("petbreed")),
        _plain(pet.get("petsex")),
        fmt_dt(pet.get("petbirthday")),
        owner_name, owner_phone, owner_address,
        fmt_dt(opd.get("opd_datetime")),
        _plain(opd.get("doctor_name")),
        _plain(opd.get("opd_T")),
        _plain(opd.get("opd_P")),
        _plain(opd.get("opd_R")),
        _plain(opd.get("opd_weight_kg")),
        _plain(opd.get("opd_pain_score")),
        rich_txt(opd.get("opd_cc")),
        rich_txt(opd.get("suggestion")),
        rich_txt(opd.get("reportlab")),
        _plain(pe.get("pet_weight")),
        _plain(pe.get("pet_temperature")),
        _plain(pe.get("pet_bp")),
        _plain(pe.get("pet_hr")),
        _plain(pe.get("pet_rr")),
        _plain(pe.get("pet_bcs")),
        _plain(pe.get("pet_mm")),
        _plain(pe.get("pet_crt")),
        _plain(pe.get("hydration")),
        rich_txt(pe.get("more_info")),
        rich_txt(pe.get("content")),
        rich_txt(pe.get("treatment")),
        rich_txt(pe.get("comment")),
        to_json(vaccines),
        to_json(prognoses),
        to_json(treatments),
        to_json(labs),
    ]

    # MERGE params: 1 (key for USING) + 37 (UPDATE SET) + 1 (key for INSERT) + 37 (VALUES)
    ms_cur.execute(_UPSERT_OPD, [opd_id] + data + [opd_id] + data)


def migrate_ipd(ms_cur, ah, pet, customer,
                labs, body, eat, general, other, plan, talk, treatment):
    owner_name, owner_phone, _ = _owner_parts(customer)
    ahid = ah["admit_history_id"]
    status = _plain(ah.get("admit_status_name") or ah.get("admit_status_text"))

    # 29 data columns
    data = [
        pet.get("pet_uid"),
        _plain(pet.get("petid")),
        _plain(pet.get("petname")),
        _plain(pet.get("pettype")),
        _plain(pet.get("petbreed")),
        _plain(pet.get("petsex")),
        fmt_dt(pet.get("petbirthday")),
        owner_name, owner_phone,
        fmt_dt(ah.get("admit_since_date")),
        fmt_dt(ah.get("admit_to_date")),
        status,
        ah.get("doctor_id"),
        _plain(ah.get("doctor_name")),
        rich_txt(ah.get("history")),
        rich_txt(ah.get("physical")),
        rich_txt(ah.get("differential")),
        rich_txt(ah.get("final")),
        rich_txt(ah.get("prognosis")),
        rich_txt(ah.get("suggestion")),
        rich_txt(ah.get("reportlab")),
        to_json(labs),
        to_json(body),
        to_json(eat),
        to_json(general),
        to_json(other),
        to_json(plan),
        to_json(talk),
        to_json(treatment),
    ]

    # MERGE params: 1 (key for USING) + 29 (UPDATE SET) + 1 (key for INSERT) + 29 (VALUES)
    ms_cur.execute(_UPSERT_IPD, [ahid] + data + [ahid] + data)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print("Connecting to MySQL  (source)...")
    my_conn = mysql_connect()

    print("Preparing MSSQL database...")
    ensure_mssql_database()

    print("Connecting to MSSQL  (destination)...")
    ms_conn = mssql_connect()

    try:
        print("Ensuring destination tables exist...")
        ensure_tables(ms_conn)

        print("Fetching all pets from MySQL...")
        pets = get_all_pets(my_conn)
        print(f"Found {len(pets)} pet(s).  Starting migration...\n")

        opd_total = 0
        ipd_total = 0
        err_total = 0

        for pet in pets:
            pet_uid  = pet["pet_uid"]
            petid    = _plain(pet.get("petid")) or str(pet_uid)
            customer = get_customer(my_conn, pet["cuid"]) if pet.get("cuid") else None

            ms_cur = ms_conn.cursor()

            try:
                # ── OPD records ──
                opds = get_opds(my_conn, pet_uid)
                for opd in opds:
                    pe         = get_physical_exam(my_conn, opd["queue_uid"]) if opd.get("queue_uid") else None
                    vaccines   = get_vaccines(my_conn, opd["opd_id"])
                    prognoses  = get_prognosis(my_conn, opd["opd_id"])
                    treatments = get_treatment(my_conn, opd["opd_id"])
                    labs       = get_labs(my_conn, opd["opd_id"])
                    migrate_opd(ms_cur, opd, pet, customer, pe,
                                vaccines, prognoses, treatments, labs)
                    opd_total += 1

                # ── Admit / IPD records ──
                admits = get_admit_histories(my_conn, pet_uid)
                for ah in admits:
                    ahid = ah["admit_history_id"]
                    migrate_ipd(
                        ms_cur, ah, pet, customer,
                        labs      = get_admit_labs(my_conn, ahid),
                        body      = get_admit_monitor_body(my_conn, ahid),
                        eat       = get_admit_monitor_eat(my_conn, ahid),
                        general   = get_admit_monitor_general(my_conn, ahid),
                        other     = get_admit_monitor_other(my_conn, ahid),
                        plan      = get_admit_monitor_plan(my_conn, ahid),
                        talk      = get_admit_monitor_talk(my_conn, ahid),
                        treatment = get_admit_monitor_treatment(my_conn, ahid),
                    )
                    ipd_total += 1

                ms_conn.commit()
                print(f"  [ok]  {petid}  -- {len(opds)} OPD(s), {len(admits)} IPD(s)")

            except Exception as exc:
                ms_conn.rollback()
                err_total += 1
                print(f"  [ERR] {petid}  -- {exc}")

        print(
            f"\nMigration complete."
            f"  OPD rows: {opd_total}"
            f"  |  IPD rows: {ipd_total}"
            f"  |  Errors: {err_total}"
        )

    finally:
        my_conn.close()
        ms_conn.close()


if __name__ == "__main__":
    main()
