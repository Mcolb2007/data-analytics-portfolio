-- Which period of day carries the most passengers?
-- ORDER BY the aggregated total, not the label, so the peak is
-- the first row.

SELECT
    time_period,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY time_period
ORDER BY total_journeys DESC;
