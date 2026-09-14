-- SkillBuilder 5 — JOIN and UNION
-- No SkillBuilder 5 Practice Doc was in Drive. These are the course
-- Summary examples, plus the same patterns used in the portfolio.

-- =============================================================================
-- Summary examples
-- =============================================================================

-- INNER JOIN: only rows that match on both sides.
SELECT
    a.title,
    b.name
FROM chinook.album AS a
INNER JOIN chinook.artist AS b
    ON a.artist_id = b.artist_id;

-- LEFT JOIN: keep every customer, even with no order.
SELECT
    a.customername,
    b.ordernumber
FROM initech.customers AS a
LEFT JOIN initech.orders AS b
    ON a.customernumber = b.customernumber;

-- FULL OUTER JOIN: unmatched albums AND unmatched tracks.
SELECT
    a.album_id,
    a.title AS album_title,
    b.name AS track_title
FROM chinook.album AS a
FULL OUTER JOIN chinook.track AS b
    ON a.album_id = b.album_id;

-- UNION: stack two years of earthquakes (drops duplicate rows).
SELECT time, mag, place FROM earthquake.data2015
UNION
SELECT time, mag, place FROM earthquake.data2016;


-- =============================================================================
-- Same patterns in the portfolio (already written; listed here to drill)
-- =============================================================================

-- FastKitchen: keep guest orders (NULL user_id) — project 10
-- SELECT *
-- FROM fastkitchen.orders
-- LEFT JOIN fastkitchen.users
--     ON orders.user_id = users.user_id;

-- Terracotta: attach plant care to each survey row — project 14
-- SELECT *
-- FROM terracotta.survey AS s
-- LEFT JOIN terracotta.plant_info AS p
--     ON s.plant_types = p.plant;

-- Intel: keep every device even without an impact row — project 05
-- SELECT *
-- FROM intel.device_data AS d
-- LEFT JOIN intel.impact_data AS i
--     ON d.device_id = i.device_id;
