from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
from utils.db_utils import query_database

def main():
    query = "SELECT * FROM OPD"  # Change to your actual table
    results = query_database(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        db=DB_NAME,
        query=query
    )
    for row in results:
        print(row)

if __name__ == "__main__":
    main()
