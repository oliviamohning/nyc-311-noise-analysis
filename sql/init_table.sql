-- init_table.sql
-- Load raw NYC 311 noise complaint CSV into Postgres, create an analysis-ready table,
-- export to CSV.

\set ON_ERROR_STOP on

DROP TABLE IF EXISTS noise_complaints_2024 CASCADE;
DROP TABLE IF EXISTS noise_complaints_clean CASCADE;

CREATE TABLE noise_complaints_2024 (
    unique_key BIGINT,
    created_date TIMESTAMP,
    closed_date TIMESTAMP,
    agency TEXT,
    agency_name TEXT,
    complaint_type TEXT,
    descriptor TEXT,
    location_type TEXT,
    incident_zip TEXT,
    incident_address TEXT,
    street_name TEXT,
    cross_street_1 TEXT,
    cross_street_2 TEXT,
    intersection_street_1 TEXT,
    intersection_street_2 TEXT,
    address_type TEXT,
    city TEXT,
    landmark TEXT,
    facility_type TEXT,
    status TEXT,
    due_date TIMESTAMP,
    resolution_description TEXT,
    resolution_action_updated_date TIMESTAMP,
    community_board TEXT,
    bbl BIGINT,
    borough TEXT,
    x_coordinate DOUBLE PRECISION,
    y_coordinate DOUBLE PRECISION,
    open_data_channel_type TEXT,
    park_facility_name TEXT,
    park_borough TEXT,
    vehicle_type TEXT,
    taxi_company_borough TEXT,
    taxi_pick_up_location TEXT,
    bridge_highway_name TEXT,
    bridge_highway_direction TEXT,
    road_ramp TEXT,
    bridge_highway_segment TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    location TEXT
);

\copy noise_complaints_2024 FROM 'data_raw/311_noise_complaints_2024.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE noise_complaints_clean AS
SELECT
    unique_key,
    created_date,
    closed_date,
    agency,
    complaint_type,
    descriptor,
    borough,
    latitude,
    longitude
FROM noise_complaints_2024;

CREATE INDEX IF NOT EXISTS idx_noise_created_date ON noise_complaints_clean (created_date);
CREATE INDEX IF NOT EXISTS idx_noise_borough ON noise_complaints_clean (borough);
CREATE INDEX IF NOT EXISTS idx_noise_complaint_type ON noise_complaints_clean (complaint_type);

\copy noise_complaints_clean TO 'data_processed/noise_complaints_clean_sql.csv' CSV HEADER;

SELECT COUNT(*) AS row_count FROM noise_complaints_clean;
SELECT * FROM noise_complaints_clean ORDER BY created_date NULLS LAST LIMIT 10;
