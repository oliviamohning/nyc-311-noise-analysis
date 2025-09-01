# NYC Noise Complaint Analysis

This project analyzes NYC 311 noise complaint data to uncover spatial and temporal patterns and forecast future complaint volumes. By understanding when and where noise complaints are most likely to occur, city agencies can better allocate enforcement resources and address recurring problem areas. The goal is to help answer questions like:
- When do most noise complaints occur?
- Which boroughs report the most noise?
- Are there seasonal or time-based trends?
- Can we forecast complaint volume over time? By season? By location?

## Tools Used
- Python (pandas, numpy, matplotlib, seaborn, scikit-learn) for data cleaning, exploration, and forecasting
- SQL for querying, aggregating, and joining datasets
- Jupyter Notebooks for exploratory analysis and model development

## Dataset
NYC 311 Service Requests filtered to noise complaints (sample dataset: 311_noise_complaints_2024.csv). Includes date/time, complaint type, borough, and geolocation information.

## Repository Structure
```
nyc-noise/
├── data_raw/                         # Raw data (unmodified source files)
│   └── 311_noise_complaints_2024.csv
├── data_processed/                   # Cleaned/aggregated data ready for analysis
├── notebooks/                        # Jupyter notebooks for EDA, forecasting, mapping
│   └── nyc_311_noise_analysis.ipynb
├── src/                              # Python scripts for cleaning, feature engineering
├── assets/                           # Images/plots for README and reports
├── dashboards/                       # Tableau/Power BI dashboards
├── reports/                          # Project reports or summaries
├── sql/
│   └── init_table.sql                # Drops/creates table + loads CSV
├── scripts/
│   └── setup_db.py                   # Creates database + runs init_table.sql
│
├── requirements.txt                  # Python dependencies (pip)
├── environment.yml                   # Conda environment (alternative to requirements.txt)
├── LICENSE                           # Open-source license
└── README.md                         # Project overview and instructions
```

## Status (updated September 1, 2025)
Adding an ETL pipeline using SQL

## Next Steps
- Build baseline time series forecast models (seasonal naive, SARIMA)
- Evaluate model accuracy and identify high-risk time windows
- Create a Tableau dashboard for interactive exploration
- Document results and policy recommendations

## Getting Started
This project includes a setup script in `scripts/setup_db.py` that initializes a PostgreSQL database, builds tables, and loads the raw noise complaints data for analysis.

### Prerequisites
- PostgreSQL installed and accessible via `psql`  
- Python 3 with Conda (or Mamba) installed  
- A PostgreSQL user with permission to create databases and tables  

### Set up the environment
From the repo root (`nyc-noise/`), create and activate the environment:

```bash
conda env create -f environment.yml
conda activate nyc-noise
```

### Load the data into PostgreSQL
Once the environment is active, run:

```bash
python scripts/setup_db.py
```

This will:  
1. Create a database called `nyc_noise` if it does not already exist.  
2. Run `sql/init_table.sql` to create the `noise_complaints_2024` table.  
3. Load data from `data_raw/311_noise_complaints_2024.csv`.  

### Notes
- By default the script uses your system username as the Postgres user.  
- To override, set the environment variable `PGUSER` before running the script:  

```bash
PGUSER=your_pg_username python scripts/setup_db.py
```
