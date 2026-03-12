-- Tell MySQL which database to use
USE cyclistic_db;

-- Run the Master Data Cleaning Query
CREATE TABLE tripdata_cleaned AS
SELECT 
    NULLIF(ride_id, '') AS ride_id,
    NULLIF(rideable_type, '') AS rideable_type,
    CAST(started_at AS DATETIME) AS started_at,
    CAST(ended_at AS DATETIME) AS ended_at,
    NULLIF(start_station_name, '') AS start_station_name,
    NULLIF(end_station_name, '') AS end_station_name,
    CAST(NULLIF(start_lat, '') AS DECIMAL(10,6)) AS start_lat,
    CAST(NULLIF(start_lng, '') AS DECIMAL(10,6)) AS start_lng,
    CAST(NULLIF(end_lat, '') AS DECIMAL(10,6)) AS end_lat,
    CAST(NULLIF(end_lng, '') AS DECIMAL(10,6)) AS end_lng,
    NULLIF(member_casual, '') AS member_casual,
    TIMESTAMPDIFF(MINUTE, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) AS ride_length_mins,
    DAYNAME(CAST(started_at AS DATETIME)) AS day_of_week
FROM 
    tripdata
WHERE 
    LENGTH(started_at) >= 16 AND LENGTH(ended_at) >= 16
    AND start_station_name IS NOT NULL AND start_station_name != ''
    AND end_station_name IS NOT NULL AND end_station_name != ''
    AND TIMESTAMPDIFF(MINUTE, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) > 0;