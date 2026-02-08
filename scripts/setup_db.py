import subprocess
import sys
import os
from pathlib import Path

# Always run relative to the repo root (parent of scripts/)
repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)

# Settings
DB_NAME = os.getenv("DB_NAME", "nyc_noise")

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
import getpass
DB_USER = os.getenv("PGUSER") or getpass.getuser()


def require_cmd(cmd):
    if subprocess.call(f"command -v {cmd}", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) != 0:
        print(f"Required command not found: {cmd}")
        sys.exit(1)

def run_command(cmd):
    print(f"> {cmd}")
    try:
        subprocess.run(cmd, check=True, shell=True)
    except subprocess.CalledProcessError:
        sys.exit(1)

def main():
    require_cmd("psql")
    require_cmd("createdb")

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
    run_command(f'createdb -U {DB_USER} {DB_NAME} || echo "Database {DB_NAME} already exists"')

    # 4. Run ETL SQL script
    print(f"Running ETL script: {SQL_FILE}")
    run_command(f'psql -U {DB_USER} -d {DB_NAME} -f {SQL_FILE}')

    print("Repo and database setup complete.")

if __name__ == "__main__":
    main()
