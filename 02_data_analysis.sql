-- 1. Total Rides by Member Type and Day of Week
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

-- 2. Average Ride Length by Member Type and Day of Week
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

-- 3. Total Rides by Member Type and Hour of Day
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