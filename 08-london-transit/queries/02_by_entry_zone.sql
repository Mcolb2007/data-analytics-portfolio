-- Where do journeys start?
-- Zone 1 is central London; higher zones are rings around it.
-- Divide Zone 1's total by the citywide total from 01 (outside SQL)
-- to get the share.

SELECT
    entry_zone,
    SUM(daily_journeys) AS total_journeys
FROM tfl.rods
GROUP BY entry_zone;
