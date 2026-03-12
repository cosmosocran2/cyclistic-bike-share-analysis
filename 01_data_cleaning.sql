/*
===============================================================================
Project: Cyclistic Bike-Share Analysis
Author: Cosmos Ocran
Description: This script cleans and structures 12 months of raw bike-share data 
             (3.6+ million rows) into an analysis-ready format. It standardizes 
             data types, handles null values, calculates ride durations, and 
             removes invalid test entries.
===============================================================================
*/

-- Step 1: Select the database
USE cyclistic_db;

-- Step 2: Create a clean, optimized table for analysis
CREATE TABLE tripdata_cleaned AS
SELECT 
    -- Standardize IDs and types (Treating empty strings as true NULLs)
    NULLIF(ride_id, '') AS ride_id,
    NULLIF(rideable_type, '') AS rideable_type,
    
    -- Convert string timestamps to strict DATETIME formats
    CAST(started_at AS DATETIME) AS started_at,
    CAST(ended_at AS DATETIME) AS ended_at,
    
    -- Extract station information
    NULLIF(start_station_name, '') AS start_station_name,
    NULLIF(end_station_name, '') AS end_station_name,
    
    -- Convert coordinates to exact decimals for potential geographic mapping
    CAST(NULLIF(start_lat, '') AS DECIMAL(10,6)) AS start_lat,
    CAST(NULLIF(start_lng, '') AS DECIMAL(10,6)) AS start_lng,
    CAST(NULLIF(end_lat, '') AS DECIMAL(10,6)) AS end_lat,
    CAST(NULLIF(end_lng, '') AS DECIMAL(10,6)) AS end_lng,
    
    -- Define user type
    NULLIF(member_casual, '') AS member_casual,
    
    -- FEATURE ENGINEERING: Calculate exact ride duration in minutes
    TIMESTAMPDIFF(MINUTE, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) AS ride_length_mins,
    
    -- FEATURE ENGINEERING: Extract the day of the week for behavioral analysis
    DAYNAME(CAST(started_at AS DATETIME)) AS day_of_week
FROM 
    tripdata
WHERE 
    -- CLEANING RULE 1: Ensure dates are fully formatted strings before converting
    LENGTH(started_at) >= 16 AND LENGTH(ended_at) >= 16
    
    -- CLEANING RULE 2: Remove any incomplete trips missing a start or end station
    AND start_station_name IS NOT NULL AND start_station_name != ''
    AND end_station_name IS NOT NULL AND end_station_name != ''
    
    -- CLEANING RULE 3: Filter out invalid durations 
    -- (e.g., negative times from system errors, or 0-minute false starts)
    AND TIMESTAMPDIFF(MINUTE, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) > 0;
