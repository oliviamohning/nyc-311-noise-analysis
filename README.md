# NYC Noise Complaint Analysis

This project analyzes NYC 311 noise complaint data to uncover spatial and temporal patterns and forecast future complaint volumes. By understanding when and where noise complaints are most likely to occur, city agencies can better allocate enforcement resources and address recurring problem areas.

This project analyzes NYC 311 noise complaint data to identify spatial and temporal patterns. The goal is to help answer questions like:

- When do most noise complaints occur?
- Which boroughs report the most noise?
- Are there seasonal or time-based trends?
- Can we forecast complaint volume over time? By season? By location?

## Tools Used
- Python (pandas, numpy, matplotlib, seaborn, scikit-learn) for data cleaning, exploration, and forecasting
- SQL for querying, aggregating, and joining datasets
- Jupyter Notebooks for exploratory analysis and model development

## Dataset
NYC 311 Service Requests filtered to noise complaints (sample dataset: 311_noise_complaints_sample_small.csv). Includes date/time, complaint type, borough, and geolocation information.

## Repository Structure
```
nyc-311-noise-analysis/
│
├── data_raw/              # Raw data (unmodified source files)
├── data_processed/        # Cleaned/aggregated data ready for analysis
├── notebooks/             # Jupyter notebooks for EDA, forecasting, mapping
├── src/                   # Python scripts for cleaning, feature engineering
├── assets/                # Images/plots for README and reports
├── dashboards/            # Tableau/Power BI dashboards
├── reports/               # Project reports or summaries
├── sql/                   # SQL queries and scripts
│
├── requirements.txt       # Python dependencies
├── LICENSE                # Open-source license
└── README.md              # Project overview
```

## Status
Data cleaning and exploratory analysis in progress (updated August 11, 2025)

## Next Steps
- Build baseline time series forecast models (seasonal naive, SARIMA)
- Evaluate model accuracy and identify high-risk time windows
- Create a Tableau dashboard for interactive exploration
- Document results and policy recommendations