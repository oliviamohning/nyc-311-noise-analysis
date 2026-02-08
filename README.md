# NYC Noise Complaint Analysis

<img src="assets/kermit.jpg" alt="Kermit Noise Complaint Meme" width="300" align="left" />

This project analyzes NYC 311 noise complaint data to explore spatial and temporal reporting patterns and assess data quality considerations in large-scale civic datasets. The analysis focuses on understanding when and where noise complaints are reported, how reporting varies over time and location, and what limitations exist when interpreting historical complaint data.

This work is intended as an exploratory and analytical exercise, not as an operational or enforcement decision-making tool. Historical 311 complaint data reflects reporting behavior and access to services, which may vary across communities and over time, and should not be treated as a direct proxy for underlying incident rates.

## Research questions include:
- When do noise complaints tend to be reported?
- How does reported complaint volume vary by borough and time of day?
- Are there observable seasonal or temporal reporting patterns?
- What limitations arise when using historical complaint data for trend analysis or forecasting?

## Ethical and interpretive considerations
This project explicitly avoids recommending enforcement actions or resource allocation strategies. During later graduate research on AI and predictive policing, I examined how using historical data to guide future enforcement decisions can reinforce existing biases and create feedback loops that disproportionately impact marginalized communities.

As a result, forecasting and trend analysis in this repository are presented as methodological demonstrations and diagnostic tools rather than prescriptions for action. Any temporal models are included to illustrate analytical techniques and to highlight the uncertainty and limitations inherent in complaint-based data.

## Tools used
- Python (pandas, numpy, matplotlib, seaborn, scikit-learn) for data cleaning, exploratory analysis, and time series modeling.
- SQL for querying, aggregating, joining, and validating structured data.
- Jupyter Notebooks for transparent, reproducible analysis.

## Dataset
NYC 311 Service Requests filtered to noise complaints (sample dataset: 311_noise_complaints_2024.csv). Fields include date and time, complaint type, borough, and geolocation information.

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
├── environment.yml                   # Conda environment (alternative to requirements.txt)
├── LICENSE                           # Open-source license
└── README.md                         # Project overview and instructions
```

## Status (updated February 7, 2026)
Baseline exploratory analysis and initial time series modeling to examine seasonality and reporting patterns. Forecasting components are included for methodological illustration and evaluation of model limitations.

## Next steps
- Expand data validation checks and summary tables.
- Add written interpretation of observed patterns and known data limitations.
- Create a simple dashboard for exploratory, non-operational visualization.

## Notes on use
This repository is intended as a demonstration of data cleaning, validation, exploratory analysis, and documentation practices in a public-sector context. Findings should be interpreted cautiously and within the broader social, demographic, and institutional factors that influence service request data.

## Getting Started
This project uses PostgreSQL for data storage and Conda for environment management.  
Follow the steps below to set up the environment, load the data, and generate the cleaned datasets.

### Prerequisites
- PostgreSQL installed and accessible via `psql`
- Conda (or Mamba) installed
- A PostgreSQL user with permission to create databases and tables

### 1. Set up the environment
From the repo root (`nyc-noise/`), create and activate the environment:

```bash
conda env create -f environment.yml
conda activate nycnoise
```

### 2. Load data into PostgreSQL
Run the setup script to create the database, build tables, and load data:

```bash
python scripts/setup_db.py
```

This will:
1. Create a database called `nyc_noise` if it does not already exist.  
2. Run `sql/init_table.sql` to create two tables:  
   - `noise_complaints_2024` (raw, full schema)  
   - `noise_complaints_clean` (slimmed, analysis-ready schema)  
3. Export the cleaned SQL dataset to `data_processed/noise_complaints_clean_sql.csv`.  

### 3. Generate Python-cleaned dataset (optional)
You can also use the Jupyter notebook to produce a parallel cleaned dataset:

```bash
jupyter notebook notebooks/nyc_311_noise_analysis.ipynb
```

The notebook will:  
- Clean and transform the raw dataset with pandas.  
- Save an additional file to `data_processed/noise_complaints_clean_py.csv`.  
- Export key visualizations into `assets/` for use in the README or reports.  

### 4. Verify the outputs
Check the processed files in your repo:

```bash
head data_processed/noise_complaints_clean_sql.csv
head data_processed/noise_complaints_clean_py.csv
```

You can connect Tableau, Python, or other tools directly to these CSVs.  

### Notes
- By default the script uses your system username as the Postgres user.  
- To override, set the environment variable `PGUSER` before running the script:

```bash
PGUSER=your_pg_username python scripts/setup_db.py
```

## Sample Outputs & Visualizations

### Monthly Noise Complaint Trends (2024)
![Monthly Noise Trends](assets/monthly_noise_trends_2024.png)

### Geographic Heatmap of Noise Complaints
![Noise Complaints Heatmap](assets/noise_complaints_geospatial_heatmap_2024.png)
