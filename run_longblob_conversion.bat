@echo off
REM ============================================================================
REM Batch script to run LONGBLOB to TEXT conversion
REM ============================================================================

echo.
echo ========================================================================
echo LONGBLOB/BLOB to TEXT Conversion Script
echo ========================================================================
echo.
echo This script will convert all LONGBLOB and BLOB columns to TEXT in the database.
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.6 or higher
    pause
    exit /b 1
)

REM Check if .env file exists
if not exist ".env" (
    echo ERROR: .env file not found
    echo Please create .env file with database credentials
    pause
    exit /b 1
)

REM Check if required packages are installed
echo Checking dependencies...
python -c "import pymysql" >nul 2>&1
if errorlevel 1 (
    echo Installing required packages...
    pip install -r requirements.txt
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)

echo.
echo Starting conversion script...
echo.

REM Run the Python script
python scripts\convert_longblob_to_text.py

echo.
echo ========================================================================
echo Script execution completed
echo ========================================================================
echo.
pause
