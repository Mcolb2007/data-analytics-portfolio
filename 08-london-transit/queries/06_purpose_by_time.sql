-- Do people travel from Home or Work at the times you would expect?
-- Sort by purpose then period so each reason's day is readable as a
-- block, not mixed through the table.

SELECT
    origin_purpose,
    time_period,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY origin_purpose, time_period
ORDER BY origin_purpose, time_period DESC;
