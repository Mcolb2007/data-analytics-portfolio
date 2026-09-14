-- Lock the join in a CTE so later counts reuse the same grain.
-- 217 rows in survey_full.

WITH survey_full AS (
    SELECT
        s.*,
        p.*
    FROM terracotta.survey AS s
    LEFT JOIN terracotta.plant_info AS p
        ON s.plant_types = p.plant
)
SELECT *
FROM survey_full;
