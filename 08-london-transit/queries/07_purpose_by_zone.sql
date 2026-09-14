-- Does the Home vs Work mix change as you leave Zone 1?
-- Sort by zone so each ring of London reads as its own block.

SELECT
    origin_purpose,
    entry_zone,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY origin_purpose, entry_zone
ORDER BY entry_zone, origin_purpose DESC;
