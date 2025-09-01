-- init_table.sql
-- This script sets up tables for NYC noise complaints data
-- 1. Creates a full raw table (noise_complaints_2024) with all columns from the CSV
-- 2. Loads the raw CSV into that table
-- 3. Creates a clean table (noise_complaints_clean) with only the columns used for analysis
-- 4. Exports the clean table to CSV for use in Tableau or other tools
-- 5. Prints a sample of the clean table for verification

-- Remove the raw table if it already exists to avoid conflicts
DROP TABLE IF EXISTS noise_complaints_2024;

-- Create the raw table with all columns from the CSV
-- Data types are chosen to match the expected contents:
--   BIGINT for IDs, TIMESTAMP for dates, DOUBLE PRECISION for coordinates, TEXT for everything else
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

-- Load the raw CSV into the raw table
\copy noise_complaints_2024 FROM 'data_raw/311_noise_complaints_2024.csv' DELIMITER ',' CSV HEADER;

-- Remove the clean table if it exists so we can rebuild it
DROP TABLE IF EXISTS noise_complaints_clean;

-- Create the clean table with only the columns needed for analysis
CREATE TABLE noise_complaints_clean AS
SELECT
    created_date,
    agency,
    complaint_type,
    descriptor,
    borough,
    latitude,
    longitude,
    location
FROM noise_complaints_2024;

-- Export the cleaned table
\copy noise_complaints_clean TO 'data_processed/noise_complaints_clean_sql.csv' CSV HEADER;

-- Show a small sample of the clean table for quick verification
SELECT * FROM noise_complaints_clean LIMIT 10;
