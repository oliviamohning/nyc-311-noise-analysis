import subprocess
import sys
import os
from pathlib import Path

# Always run relative to the repo root (parent of scripts/)
repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)

# Settings
DB_NAME = "nyc_noise"
SQL_FILE = repo_root / "sql" / "init_table.sql"

# Repo directories we expect to exist
REQUIRED_DIRS = [
    "data_raw",
    "data_processed",
    "notebooks",
    "src",
    "sql",
    "scripts",
    "assets",
    "dashboards",
    "reports"
]

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
    # 1. Ensure repo directories exist
    print("Ensuring repo directories exist...")
    for d in REQUIRED_DIRS:
        Path(d).mkdir(parents=True, exist_ok=True)

    # 2. Check for SQL file
    if not SQL_FILE.exists():
        print(f"Could not find SQL file at {SQL_FILE}")
        sys.exit(1)

    # 3. Create database if needed
    print(f"Creating database '{DB_NAME}' if it doesn't exist...")
    run_command(f'createdb -U {DB_USER} {DB_NAME} 2> /dev/null || echo "Database {DB_NAME} already exists"')

    # 4. Run ETL SQL script
    print(f"Running ETL script: {SQL_FILE}")
    run_command(f'psql -U {DB_USER} -d {DB_NAME} -f {SQL_FILE}')

    print("Repo and database setup complete.")

if __name__ == "__main__":
    main()
