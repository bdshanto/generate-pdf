# LONGBLOB/BLOB to TEXT Conversion - Quick Start

## What This Does

Converts all LONGBLOB and BLOB columns to TEXT in your MySQL database. This affects 12 columns across 6 tables:

- `admit_history.history` (blob → text)
- `admit_history.differential` (blob → text)
- `admit_history.final` (blob → text)
- `global_note.note` (longblob → longtext)
- `opd_history.content` (longblob → longtext)
- `opd_notifications.content` (longblob → longtext)
- `opd_treatment.content` (longblob → longtext)
- `queue_history.more_info` (longblob → longtext)
- `queue_history.score` (longblob → longtext)
- `queue_history.comment` (longblob → longtext)
- `queue_history.content` (longblob → longtext)
- `queue_history.treatment` (longblob → longtext)

## Quick Start (Windows)

1. **Double-click** `run_longblob_conversion.bat`
2. Choose option **1** for dry run (preview changes)
3. Review the output
4. Run again and choose option **2** to execute
5. Confirm with `yes`

## Quick Start (Manual)

```bash
# 1. Install dependencies (if not already done)
pip install -r requirements.txt

# 2. Run the conversion script
python scripts/convert_longblob_to_text.py

# 3. Choose dry run (option 1) first to preview
# 4. Run again and execute (option 2) to convert
```

## What Gets Created

After running the script:

1. **Log file**: `longblob_to_text_conversion_YYYYMMDD_HHMMSS.log`
   - Detailed operation log

2. **Backup file**: `table_structure_backup_YYYYMMDD_HHMMSS.sql`
   - Original table structures for rollback

## Using SQL Directly

If you prefer to run SQL manually:

```bash
mysql -u username -p database_name < scripts/convert_longblob_to_text.sql
```

Or execute the ALTER TABLE statements from `scripts/convert_longblob_to_text.sql` in your MySQL client.

## Safety Features

✅ Dry run mode - preview without changes
✅ Automatic backups before conversion
✅ User confirmation required
✅ Detailed logging
✅ Transaction rollback on errors

## Documentation

For complete documentation, see: [docs/LONGBLOB_TO_TEXT_CONVERSION.md](docs/LONGBLOB_TO_TEXT_CONVERSION.md)

## Troubleshooting

**Can't connect to database?**
- Check your `.env` file has correct credentials
- Verify MySQL server is running

**Permission denied?**
- Your database user needs ALTER TABLE privileges

**Need help?**
- Check the log file for error details
- Read the full documentation
- Contact your database administrator
