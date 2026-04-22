import os
from dotenv import load_dotenv

load_dotenv()

# MySQL (source)
DB_HOST     = os.getenv("DB_HOST")
DB_USER     = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME     = os.getenv("DB_NAME")

# MSSQL (destination)
MSSQL_HOST     = os.getenv("MSSQL_HOST")
MSSQL_USER     = os.getenv("MSSQL_USER")
MSSQL_PASSWORD = os.getenv("MSSQL_PASSWORD")
MSSQL_DB       = os.getenv("MSSQL_DB")
MSSQL_DRIVER   = os.getenv("MSSQL_DRIVER", "ODBC Driver 17 for SQL Server")
