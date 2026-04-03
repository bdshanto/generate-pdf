
# PDF Generation Utility

## Technologies Used
- Python 3.x
- PyMySQL
- python-dotenv

## Project Structure
- `config/settings.py`: Loads environment variables from `.env`
- `utils/db_utils.py`: Database utility functions (MySQL)
- `scripts/generate_pdf.py`: Main PDF generation script (entry point)
- `.env.example`: Example environment file
- `requirements.txt`: Python dependencies
- `.gitignore`: Ignores IDE, Python, and environment files
- `migration.py`: Deprecated, points to old migration structure
- `datamigration/`: Python package marker

## Setup & Run

1. **Install dependencies**
   ```sh
   pip install -r requirements.txt
   ```

2. **Configure environment variables**
   - Copy `.env.example` to `.env` and update values as needed.

3. **Run PDF Generation**
   ```sh
   python -m scripts.generate_pdf
   ```

## Notes
- Make sure your MySQL server is running and accessible with the credentials provided in `.env` if your PDF generation requires database access.
- The PDF generation script will generate PDFs as per your implementation.
