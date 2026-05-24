#!/usr/bin/env python3
"""
Script to convert all LONGBLOB and BLOB columns to TEXT in MySQL database.

This script:
1. Connects to the MySQL database
2. Identifies all tables with LONGBLOB and BLOB columns
3. Converts LONGBLOB columns to LONGTEXT and BLOB columns to TEXT
4. Updates the database with ALTER TABLE statements
"""

import pymysql
from typing import List, Tuple, Dict
import logging
from datetime import datetime
from config.settings import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(f'longblob_to_text_conversion_{datetime.now().strftime("%Y%m%d_%H%M%S")}.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


def get_database_connection():
    """Create and return a database connection."""
    try:
        conn = pymysql.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            db=DB_NAME,
            charset='utf8mb4'
        )
        logger.info(f"Successfully connected to database: {DB_NAME}")
        return conn
    except Exception as e:
        logger.error(f"Failed to connect to database: {e}")
        raise


def find_longblob_columns(conn) -> List[Dict[str, str]]:
    """
    Find all LONGBLOB and BLOB columns in the database.
    
    Returns:
        List of dictionaries with 'table_name', 'column_name', and 'data_type' keys
    """
    query = """
        SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLUMN_TYPE
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = %s
        AND DATA_TYPE IN ('longblob', 'blob')
        ORDER BY TABLE_NAME, COLUMN_NAME
    """
    
    try:
        with conn.cursor() as cursor:
            cursor.execute(query, (DB_NAME,))
            results = cursor.fetchall()
            
            columns = [
                {
                    'table_name': row[0],
                    'column_name': row[1],
                    'data_type': row[2],
                    'column_type': row[3]
                }
                for row in results
            ]
            
            logger.info(f"Found {len(columns)} LONGBLOB/BLOB columns")
            return columns
    except Exception as e:
        logger.error(f"Error finding LONGBLOB/BLOB columns: {e}")
        raise


def convert_longblob_to_text(conn, table_name: str, column_name: str, data_type: str, dry_run: bool = False) -> bool:
    """
    Convert a single LONGBLOB or BLOB column to TEXT.
    
    Args:
        conn: Database connection
        table_name: Name of the table
        column_name: Name of the column to convert
        data_type: Current data type ('longblob' or 'blob')
        dry_run: If True, only print the SQL without executing
    
    Returns:
        True if successful, False otherwise
    """
    # BLOB (65KB) -> TEXT (65KB)
    # LONGBLOB (4GB) -> LONGTEXT (4GB)
    # Using appropriate TEXT type to match capacity
    target_type = "LONGTEXT" if data_type.lower() == "longblob" else "TEXT"
    alter_query = f"ALTER TABLE `{table_name}` MODIFY COLUMN `{column_name}` {target_type}"
    
    if dry_run:
        logger.info(f"[DRY RUN] Would execute: {alter_query}")
        return True
    
    try:
        with conn.cursor() as cursor:
            logger.info(f"Converting {table_name}.{column_name} from {data_type.upper()} to {target_type}...")
            cursor.execute(alter_query)
            conn.commit()
            logger.info(f"✓ Successfully converted {table_name}.{column_name}")
            return True
    except Exception as e:
        logger.error(f"✗ Failed to convert {table_name}.{column_name}: {e}")
        conn.rollback()
        return False


def backup_table_structure(conn, table_name: str) -> str:
    """
    Get the CREATE TABLE statement for backup purposes.
    
    Args:
        conn: Database connection
        table_name: Name of the table
    
    Returns:
        CREATE TABLE statement as string
    """
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"SHOW CREATE TABLE `{table_name}`")
            result = cursor.fetchone()
            return result[1] if result else ""
    except Exception as e:
        logger.error(f"Failed to backup table structure for {table_name}: {e}")
        return ""


def main():
    """Main execution function."""
    logger.info("=" * 80)
    logger.info("Starting LONGBLOB/BLOB to TEXT conversion process")
    logger.info("=" * 80)
    
    # Ask for confirmation
    print("\nThis script will convert all LONGBLOB and BLOB columns to TEXT in the database.")
    print(f"Database: {DB_NAME}")
    print(f"Host: {DB_HOST}")
    print("\nOptions:")
    print("1. Dry run (show what would be changed without making changes)")
    print("2. Execute conversion")
    print("3. Cancel")
    
    choice = input("\nEnter your choice (1/2/3): ").strip()
    
    if choice == "3":
        logger.info("Operation cancelled by user")
        return
    
    dry_run = (choice == "1")
    
    if dry_run:
        logger.info("Running in DRY RUN mode - no changes will be made")
    else:
        confirm = input("\nAre you sure you want to proceed with the conversion? (yes/no): ").strip().lower()
        if confirm != "yes":
            logger.info("Operation cancelled by user")
            return
    
    conn = None
    try:
        # Connect to database
        conn = get_database_connection()
        
        # Find all LONGBLOB columns
        longblob_columns = find_longblob_columns(conn)
        
        if not longblob_columns:
            logger.info("No LONGBLOB/BLOB columns found in the database")
            return
        
        # Display found columns
        logger.info("\nFound LONGBLOB/BLOB columns:")
        for col in longblob_columns:
            logger.info(f"  - {col['table_name']}.{col['column_name']} ({col['data_type'].upper()})")
        
        # Backup table structures
        if not dry_run:
            logger.info("\nBacking up table structures...")
            backup_file = f"table_structure_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}.sql"
            with open(backup_file, 'w', encoding='utf-8') as f:
                tables_backed_up = set()
                for col in longblob_columns:
                    table_name = col['table_name']
                    if table_name not in tables_backed_up:
                        create_stmt = backup_table_structure(conn, table_name)
                        if create_stmt:
                            f.write(f"-- Backup of {table_name}\n")
                            f.write(f"{create_stmt};\n\n")
                            tables_backed_up.add(table_name)
            logger.info(f"Table structures backed up to: {backup_file}")
        
        # Convert columns
        logger.info("\nStarting conversion...")
        success_count = 0
        fail_count = 0
        
        for col in longblob_columns:
            if convert_longblob_to_text(conn, col['table_name'], col['column_name'], col['data_type'], dry_run):
                success_count += 1
            else:
                fail_count += 1
        
        # Summary
        logger.info("\n" + "=" * 80)
        logger.info("Conversion Summary")
        logger.info("=" * 80)
        logger.info(f"Total columns found: {len(longblob_columns)}")
        logger.info(f"Successfully converted: {success_count}")
        logger.info(f"Failed conversions: {fail_count}")
        
        if dry_run:
            logger.info("\nThis was a DRY RUN. No changes were made to the database.")
        else:
            logger.info("\nConversion completed!")
        
    except Exception as e:
        logger.error(f"An error occurred during execution: {e}")
        raise
    finally:
        if conn:
            conn.close()
            logger.info("Database connection closed")


if __name__ == "__main__":
    main()
