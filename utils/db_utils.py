# Utility functions for database operations
from typing import Any, List, Tuple
import pymysql

def query_database(
    host: str,
    user: str,
    password: str,
    db: str,
    query: str,
    params: Tuple = ()
) -> List[Tuple[Any, ...]]:
    """
    Query a MySQL database and return results.
    """
    conn = pymysql.connect(host=host, user=user, password=password, db=db)
    try:
        with conn.cursor() as cur:
            cur.execute(query, params)
            results = cur.fetchall()
        return results
    finally:
        conn.close()
