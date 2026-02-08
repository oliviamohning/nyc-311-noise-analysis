-- validation_and_summary.sql
-- Data quality checks + summary tables for downstream analysis/dashboards.

\set ON_ERROR_STOP on

-- Basic row count
SELECT COUNT(*) AS row_count
FROM noise_complaints_clean;

-- Missingness checks
SELECT
  SUM(CASE WHEN unique_key IS NULL THEN 1 ELSE 0 END) AS null_unique_key,
  SUM(CASE WHEN created_date IS NULL THEN 1 ELSE 0 END) AS null_created_date,
  SUM(CASE WHEN borough IS NULL OR borough = '' THEN 1 ELSE 0 END) AS null_or_empty_borough,
  SUM(CASE WHEN complaint_type IS NULL OR complaint_type = '' THEN 1 ELSE 0 END) AS null_or_empty_complaint_type
FROM noise_complaints_clean;

-- Duplicate key check
SELECT unique_key, COUNT(*) AS n
FROM noise_complaints_clean
GROUP BY unique_key
HAVING COUNT(*) > 1
ORDER BY n DESC
LIMIT 50;

-- Timestamp sanity check (created after closed)
SELECT COUNT(*) AS created_after_closed
FROM noise_complaints_clean
WHERE created_date IS NOT NULL
  AND closed_date IS NOT NULL
  AND created_date > closed_date;

-- Coordinate sanity checks (NYC-ish bounds; adjust if needed)
SELECT COUNT(*) AS lat_out_of_bounds
FROM noise_complaints_clean
WHERE latitude IS NOT NULL
  AND (latitude < 40.0 OR latitude > 41.5);

SELECT COUNT(*) AS lon_out_of_bounds
FROM noise_complaints_clean
WHERE longitude IS NOT NULL
  AND (longitude < -75.0 OR longitude > -72.0);

-- Summary table: complaints by borough and month
DROP TABLE IF EXISTS noise_by_borough_month CASCADE;

CREATE TABLE noise_by_borough_month AS
SELECT
  DATE_TRUNC('month', created_date) AS month,
  borough,
  COUNT(*) AS complaint_count
FROM noise_complaints_clean
WHERE created_date IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, 2;

-- Summary table: top complaint types by borough
DROP TABLE IF EXISTS top_complaint_types_by_borough CASCADE;

CREATE TABLE top_complaint_types_by_borough AS
SELECT
  borough,
  complaint_type,
  COUNT(*) AS complaint_count
FROM noise_complaints_clean
WHERE borough IS NOT NULL
  AND borough <> ''
  AND complaint_type IS NOT NULL
  AND complaint_type <> ''
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Export summary tables for Tableau
\copy noise_by_borough_month TO 'data_processed/noise_by_borough_month.csv' CSV HEADER;
\copy top_complaint_types_by_borough TO 'data_processed/top_complaint_types_by_borough.csv' CSV HEADER;
