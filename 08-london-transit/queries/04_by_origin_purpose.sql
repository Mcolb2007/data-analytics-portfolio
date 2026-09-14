-- Why do people enter the system?
-- origin_purpose is the reason for choosing the start station.

SELECT
    origin_purpose,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY origin_purpose
ORDER BY total_journeys DESC;
