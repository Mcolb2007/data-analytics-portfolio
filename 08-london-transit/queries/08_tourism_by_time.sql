-- How does tourist travel sit on the clock compared with commuting?
-- WHERE before GROUP BY keeps the aggregation on the tourism slice
-- without mixing it into the commute totals.

SELECT
    origin_purpose,
    destination_purpose,
    time_period,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
WHERE origin_purpose = 'Tourist'
   OR destination_purpose = 'Tourist'
GROUP BY origin_purpose, destination_purpose, time_period
ORDER BY total_journeys DESC;
