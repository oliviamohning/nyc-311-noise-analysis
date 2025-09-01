import subprocess
import sys
import os
from pathlib import Path

# Settings
DB_NAME = "nyc_noise"
SQL_FILE = Path("sql/init_table.sql")

# Get user (fall back on OS username if PGUSER not set)
DB_USER = os.getenv("PGUSER") or os.getenv("USERNAME") or "postgres"

def run_command(cmd):
    """Run a shell command and exit on failure."""
    try:
        subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {cmd}")
        sys.exit(e.returncode)

def main():
    if not SQL_FILE.exists():
        print(f"Could not find SQL file at {SQL_FILE}")
        sys.exit(1)

    # Try to create the database (ignore error if it already exists)
    print(f"Creating database '{DB_NAME}' if it doesn't exist...")
    run_command(f'createdb -U {DB_USER} {DB_NAME} 2> /dev/null || echo "Database {DB_NAME} already exists"')

    # Run the ETL SQL script
    print(f"Running ETL script: {SQL_FILE}")
    run_command(f'psql -U {DB_USER} -d {DB_NAME} -f {SQL_FILE}')

    print("Database setup complete.")

if __name__ == "__main__":
    main()
