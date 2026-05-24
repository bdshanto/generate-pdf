# LONGBLOB/BLOB to TEXT Conversion Guide

## Overview

This document describes the process for converting all LONGBLOB and BLOB columns in the MySQL database to TEXT format (LONGTEXT for LONGBLOB, TEXT for BLOB).

## Affected Tables and Columns

The following tables contain LONGBLOB/BLOB columns that will be converted:

1. **admit_history**
   - `history` (blob → text)
   - `differential` (blob → text)
   - `final` (blob → text)

2. **global_note**
   - `note` (longblob → longtext)

3. **opd_history**
   - `content` (longblob → longtext)

4. **opd_notifications**
   - `content` (longblob → longtext)

5. **opd_treatment**
   - `content` (longblob → longtext)

6. **queue_history**
   - `more_info` (longblob → longtext)
   - `score` (longblob → longtext)
   - `comment` (longblob → longtext)
   - `content` (longblob → longtext)
   - `treatment` (longblob → longtext)

**Total: 12 columns across 6 tables**

## Why Convert LONGBLOB/BLOB to TEXT?

- **BLOB types** store binary data and can be harder to work with for text content
- **TEXT types** are designed for text data with proper character encoding support
- Both can store the same amount of data for their respective sizes:
  - BLOB (65KB) → TEXT (65KB)
  - LONGBLOB (4GB) → LONGTEXT (4GB)
- TEXT types provide better compatibility with text operations and character set conversions

## Prerequisites

1. Python 3.6 or higher
2. Required Python packages (install via `pip install -r requirements.txt`)
   - pymysql
   - python-dotenv
3. Database credentials configured in `.env` file
4. Sufficient database privileges (ALTER TABLE permission)

## Usage

### Step 1: Dry Run (Recommended)

First, run the script in dry-run mode to see what changes will be made without actually modifying the database:

```bash
python scripts/convert_longblob_to_text.py
```

When prompted, select option **1** for dry run.

This will:
- Connect to the database
- List all LONGBLOB columns found
- Show the SQL statements that would be executed
- NOT make any actual changes

### Step 2: Review the Dry Run Output

Check the console output and the log file:
- Verify all expected tables and columns are listed
- Review the ALTER TABLE statements that will be executed
- Check for any warnings or errors

### Step 3: Execute the Conversion

Once you're confident with the dry run results:

```bash
python scripts/convert_longblob_to_text.py
```

When prompted:
1. Select option **2** to execute conversion
2. Confirm with `yes` when asked

The script will:
- Create a backup of all affected table structures
- Convert each LONGBLOB column to LONGTEXT
- Log all operations
- Provide a summary of successful and failed conversions

## Backup and Safety Features

The script includes several safety features:

1. **Dry Run Mode**: Test without making changes
2. **User Confirmation**: Requires explicit confirmation before making changes
3. **Table Structure Backup**: Automatically backs up CREATE TABLE statements before conversion
4. **Detailed Logging**: All operations are logged to a timestamped log file
5. **Transaction Rollback**: Each conversion is a separate operation that can be rolled back on error

## Output Files

After running the script, you'll find:

1. **Log File**: `longblob_to_text_conversion_YYYYMMDD_HHMMSS.log`
   - Contains detailed information about the conversion process
   - Records all successes and failures

2. **Backup File**: `table_structure_backup_YYYYMMDD_HHMMSS.sql`
   - Contains CREATE TABLE statements for all affected tables
   - Can be used to restore original table structure if needed

## Manual Conversion (Alternative Method)

If you prefer to convert columns manually using SQL, you can execute these ALTER TABLE statements:

```sql
-- admit_history table
ALTER TABLE `admit_history` MODIFY COLUMN `history` TEXT;
ALTER TABLE `admit_history` MODIFY COLUMN `differential` TEXT;
ALTER TABLE `admit_history` MODIFY COLUMN `final` TEXT;

-- global_note table
ALTER TABLE `global_note` MODIFY COLUMN `note` LONGTEXT;

-- opd_history table
ALTER TABLE `opd_history` MODIFY COLUMN `content` LONGTEXT;

-- opd_notifications table
ALTER TABLE `opd_notifications` MODIFY COLUMN `content` LONGTEXT;

-- opd_treatment table
ALTER TABLE `opd_treatment` MODIFY COLUMN `content` LONGTEXT;

-- queue_history table
ALTER TABLE `queue_history` MODIFY COLUMN `more_info` LONGTEXT;
ALTER TABLE `queue_history` MODIFY COLUMN `score` LONGTEXT;
ALTER TABLE `queue_history` MODIFY COLUMN `comment` LONGTEXT;
ALTER TABLE `queue_history` MODIFY COLUMN `content` LONGTEXT;
ALTER TABLE `queue_history` MODIFY COLUMN `treatment` LONGTEXT;
```

## Verificationspecific tables
DESCRIBE admit_history;

After conversion, verify the changes:

```sql
-- Check data types of all columns in a specific table
DESCRIBE global_note;
DESCRIBE opd_history;
DESCRIBE opd_notifications;
DESCRIBE opd_treatment;
DESCRIBE queue_history;

-- Or query INFORMATION_SCHEMA to see all TEXT columns
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = history', 'differential', 'final', ''your_database_name'
AND COLUMN_NAME IN ('note', 'content', 'more_info', 'score', 'comment', 'treatment')
ORDER BY TABLE_NAME, COLUMN_NAME;
```

## Rollback (If Needed)

If you need to rollback the changes:

1. Use the backup file generated: `table_structure_backup_YYYYMMDD_HHMMSS.sql`
2. Drop the modified tables
3. Recreate them using the backup file
4. Restore data from a database backup
/BLOB:

```sql
-- For LONGBLOB columns
ALTER TABLE `table_name` MODIFY COLUMN `column_name` LONGBLOB;

-- For BLOB columns
ALTER TABLE `table_name` MODIFY COLUMN `column_name` 
ALTER TABLE `table_name` MODIFY COLUMN `column_name` LONGBLOB;
```

## Troubleshooting

### Permission Denied
**Error**: Access denied; you need the ALTER privilege for this operation
**Solution**: Ensure your database user has ALTER TABLE privileges

### Connection Issues
**Error**: Can't connect to MySQL server
**Solution**: 
- Verify database credentials in `.env` file
- Check if MySQL server is running
- Verify network connectivity and firewall rules

### Lock Wait Timeout
**Error**: Lock wait timeout exceeded
**Solution**: 
- Ensure no other processes are using the tables
- Try running during off-peak hours
- Increase `innodb_lock_wait_timeout` if necessary

## Performance Considerations

- **Large Tables**: For tables with millions of rows, the ALTER TABLE operation may take time
- **Downtime**: Consider scheduling this during maintenance windows
- **Table Locking**: The operation may lock tables temporarily
- **Disk Space**: Ensure sufficient disk space (MySQL may need temporary storage)

## Best Practices

1. Always run a dry run first
2. Back up the entire database before conversion
3. Schedule during low-traffic periods
4. Monitor the log files for any issues
5. Verify data integrity after conversion
6. Test application functionality with converted columns

## Support

For issues or questions:
- Check the log files for detailed error messages
- Review the MySQL error log
- Contact the database administrator
