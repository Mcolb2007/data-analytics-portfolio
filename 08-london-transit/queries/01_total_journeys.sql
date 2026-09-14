-- How many Underground journeys happen on a typical November weekday?
-- SUM(daily_journeys), not COUNT(*). Each row is a travel profile,
-- not a single trip.

SELECT
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods;
