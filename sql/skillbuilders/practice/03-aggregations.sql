-- SkillBuilder 3 Practice — COUNT, SUM, MIN/MAX, AVG, GROUP BY, AS
-- Original Doc: https://docs.google.com/document/d/1QqUoolccaO2ZbKNAmnBX3Mn9YyJJpmYCiKJjQ0lL-8w
-- Empty boxes filled. Row counts: read from SQL Pad.

-- =============================================================================
-- Aggregations
-- =============================================================================

-- 1. How many at-bats in mlb.atbats?
--    Too many rows to count from a SELECT *; use COUNT(*).
SELECT COUNT(*) AS n_atbats
FROM mlb.atbats;

-- 2. How long to ride every Disney ride? SUM of ride_duration.
SELECT SUM(ride_duration) AS total_ride_minutes
FROM disney.rides;

-- 3. Min, max, average quoted list price of sales_data.cars.
--    Is the average closer to the min or the max?
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM sales_data.cars;


-- =============================================================================
-- GROUP BY  |  lyft.baywheels
-- =============================================================================

-- 1. Total bike rides.
SELECT COUNT(*) AS n_trips
FROM lyft.baywheels;

-- 2. Members vs casual riders.
SELECT
    member_casual,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY member_casual
ORDER BY n_trips DESC;

-- 3. Docked vs electric bikes.
SELECT
    rideable_type,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY rideable_type
ORDER BY n_trips DESC;

-- 4. Rider type × bike type. Does each rider group match the
--    overall electric-vs-docked mix?
SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY member_casual, rideable_type
ORDER BY member_casual, n_trips DESC;


-- =============================================================================
-- Aliases  |  airbnb.listings
-- =============================================================================

-- 1. Average and highest price by city.
--    Is the city with the priciest single listing also the highest average?
SELECT
    city,
    AVG(price) AS avg_price,
    MAX(price) AS max_price
FROM airbnb.listings
GROUP BY city
ORDER BY avg_price DESC;

-- 2. Add average reviews. Do high-review cities cost more or less?
--    (Use SQL Pad's chart creator for the scatter if you want.)
SELECT
    city,
    AVG(price) AS avg_price,
    MAX(price) AS max_price,
    AVG(number_of_reviews) AS avg_reviews
FROM airbnb.listings
GROUP BY city
ORDER BY avg_price DESC;

-- 3. Challenge: also group by room_type. Color the scatter by room type.
SELECT
    city,
    room_type,
    AVG(price) AS avg_price,
    MAX(price) AS max_price,
    AVG(number_of_reviews) AS avg_reviews
FROM airbnb.listings
GROUP BY city, room_type
ORDER BY city, avg_price DESC;
