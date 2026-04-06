"""Overwrites generate_medical_pdf.py with the fpdf2 version."""
import os

NEW_CONTENT = '''\
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

# \\u2500 Thai font paths \\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500\\u2500
_LEELAWAD_REG  = r"C:\\\\Windows\\\\Fonts\\\\LEELAWAD.TTF"
_LEELAWAD_BOLD = r"C:\\\\Windows\\\\Fonts\\\\LEELAWDB.TTF"
_TAHOMA_REG    = r"C:\\\\Windows\\\\Fonts\\\\tahoma.ttf"
_TAHOMA_BOLD   = r"C:\\\\Windows\\\\Fonts\\\\tahomabd.ttf"

if os.path.exists(_LEELAWAD_REG):
    _FONT_REG  = _LEELAWAD_REG
    _FONT_BOLD = _LEELAWAD_BOLD if os.path.exists(_LEELAWAD_BOLD) else _LEELAWAD_REG
else:
    _FONT_REG  = _TAHOMA_REG
    _FONT_BOLD = _TAHOMA_BOLD
'''

target = os.path.join(os.path.dirname(__file__), "generate_medical_pdf.py")
print("Would write to:", target)
print("First 200 chars:", NEW_CONTENT[:200])
