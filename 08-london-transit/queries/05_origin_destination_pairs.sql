-- What origin-destination purpose pairs actually move?
-- GROUP BY two columns. Home as an origin is not the same fact as
-- Home → Work as a pair.

SELECT
    origin_purpose,
    destination_purpose,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY origin_purpose, destination_purpose
ORDER BY total_journeys DESC;
