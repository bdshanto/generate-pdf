
# Data Migration and Utility Tools

## Technologies Used
- Python 3.x
- PyMySQL
- python-dotenv

## Project Structure
- `config/settings.py`: Loads environment variables from `.env`
- `utils/db_utils.py`: Database utility functions (MySQL)
- `scripts/`: Collection of utility scripts
  - `generate_pdf.py`: PDF generation script
  - `convert_longblob_to_text.py`: Database schema conversion tool
  - `convert_longblob_to_text.sql`: SQL statements for manual conversion
  - Other migration and utility scripts
- `docs/`: Documentation files
  - `LONGBLOB_TO_TEXT_CONVERSION.md`: Guide for LONGBLOB conversion
- `.env.example`: Example environment file
- `requirements.txt`: Python dependencies
- `.gitignore`: Ignores IDE, Python, and environment files

## Setup & Run

1. **Install dependencies**
   ```sh
   pip install -r requirements.txt
   ```

2. **Configure environment variables**
   - Copy `.env.example` to `.env` and update values as needed.

## Available Tools

### PDF Generation
```sh
python -m scripts.generate_pdf
```

### LONGBLOB/BLOB to TEXT Conversion
Convert all LONGBLOB and BLOB columns to TEXT types in the database.

**Windows:**
```sh
run_longblob_conversion.bat
```

**Manual:**
```sh
python scripts/convert_longblob_to_text.py
```

**Features:**
- Dry run mode to preview changes
- Automatic table structure backup
- Detailed logging
- User confirmation before making changes

For detailed documentation, see [LONGBLOB_TO_TEXT_CONVERSION.md](docs/LONGBLOB_TO_TEXT_CONVERSION.md)

## Notes
- Make sure your MySQL server is running and accessible with the credentials provided in `.env`.
- Always backup your database before running conversion scripts.
- Check log files for detailed operation information.
