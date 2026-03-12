/*
===============================================================================
Project: Cyclistic Bike-Share Analysis
Author: Cosmos Ocran
Description: This script aggregates the cleaned trip data to uncover behavioral 
             differences between Annual Members and Casual Riders. The outputs 
             from these queries directly feed the Tableau dashboard visualizations.
===============================================================================
*/

USE cyclistic_db;

-- ============================================================================
-- QUERY 1: High-Level Overview (Volume & Duration)
-- Objective: Establish baseline metrics for both user groups.
-- ============================================================================
SELECT 
    member_casual,
    COUNT(ride_id) AS total_rides,
    ROUND(AVG(ride_length_mins), 2) AS average_ride_length_mins,
    MAX(ride_length_mins) AS max_ride_length_mins
FROM 
    tripdata_cleaned
GROUP BY 
    member_casual;


-- ============================================================================
-- QUERY 2: Daily Usage Patterns (Volume by Day)
-- Objective: Determine which days of the week experience the highest traffic 
--            for each user cohort.
-- ============================================================================
SELECT 
    member_casual,
    day_of_week,
    COUNT(ride_id) AS total_rides
FROM 
    tripdata_cleaned
GROUP BY 
    member_casual, 
    day_of_week
ORDER BY 
    member_casual, 
    FIELD(day_of_week, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');


-- ============================================================================
-- QUERY 3: Ride Length by Day of the Week
-- Objective: Analyze how trip duration fluctuates throughout the week to 
--            differentiate between utility and leisure riding.
-- ============================================================================
SELECT 
    member_casual,
    day_of_week,
    ROUND(AVG(ride_length_mins), 2) AS average_ride_length_mins
FROM 
    tripdata_cleaned
GROUP BY 
    member_casual, 
    day_of_week
ORDER BY 
    member_casual, 
    FIELD(day_of_week, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');


-- ============================================================================
-- QUERY 4: Hypothesis Testing (Hourly Commuter Traffic)
-- Objective: Segment ride volume by the hour of the day to validate the 
--            "Weekday Commuter vs. Weekend Leisure" hypothesis.
-- ============================================================================
SELECT 
    member_casual,
    HOUR(started_at) AS hour_of_day,
    COUNT(ride_id) AS total_rides
FROM 
    tripdata_cleaned
GROUP BY 
    member_casual, 
    HOUR(started_at)
ORDER BY 
    member_casual, 
    hour_of_day;
