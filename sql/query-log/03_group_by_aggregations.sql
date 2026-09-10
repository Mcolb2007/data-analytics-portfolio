-- GROUP BY and aggregations
-- Problem: On a typical weekday, why are people on the London
-- Underground, and from which zone do they start?
-- Dataset: tfl.rods (Milestone 3)
-- Why this pattern: Each row is a travel profile, not a single trip.
-- SUM(daily_journeys) is the volume; COUNT(*) would count profiles
-- and understate Zone 1.

SELECT
    origin_purpose,
    destination_purpose,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY origin_purpose, destination_purpose
ORDER BY total_journeys DESC;

SELECT
    entry_zone,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY entry_zone;
