import subprocess
import sys
import os
from pathlib import Path
import getpass

# Always run relative to the repo root (parent of scripts/)
repo_root = Path(__file__).resolve().parent.parent
os.chdir(repo_root)

# Settings
DB_NAME = os.getenv("DB_NAME", "nyc_noise")
DB_USER = os.getenv("PGUSER") or getpass.getuser()

SQL_FILE = repo_root / "sql" / "init_table.sql"
VALIDATION_SQL_FILE = repo_root / "sql" / "validation_and_summary.sql"

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

def require_cmd(cmd):
    if subprocess.call(
        f"command -v {cmd}",
        shell=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    ) != 0:
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

    print("Ensuring repo directories exist...")
    for d in REQUIRED_DIRS:
        Path(d).mkdir(parents=True, exist_ok=True)

    if not SQL_FILE.exists():
        print(f"Could not find SQL file at {SQL_FILE}")
        sys.exit(1)

    if not VALIDATION_SQL_FILE.exists():
        print(f"Could not find SQL file at {VALIDATION_SQL_FILE}")
        sys.exit(1)

    print(f"Creating database '{DB_NAME}' if it doesn't exist...")
    run_command(f'createdb -U {DB_USER} {DB_NAME} || echo "Database {DB_NAME} already exists"')

    print(f"Running ETL script: {SQL_FILE}")
    run_command(f'psql -U {DB_USER} -d {DB_NAME} -f {SQL_FILE}')

    print(f"Running validation script: {VALIDATION_SQL_FILE}")
    run_command(f'psql -U {DB_USER} -d {DB_NAME} -f {VALIDATION_SQL_FILE}')

    print("Repo and database setup complete.")

if __name__ == "__main__":
    main()
