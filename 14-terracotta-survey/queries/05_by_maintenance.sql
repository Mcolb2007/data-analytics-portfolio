-- Which maintenance level do customers actually buy?
WITH survey_full AS (
    SELECT
        s.*,
        p.*
    FROM terracotta.survey AS s
    LEFT JOIN terracotta.plant_info AS p
        ON s.plant_types = p.plant
)
SELECT
    COUNT(*) AS num_responses,
    maintenance_requirements
FROM survey_full
GROUP BY maintenance_requirements
ORDER BY num_responses DESC;
