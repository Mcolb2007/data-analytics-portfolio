-- Pet and child safety of the plants people say they buy.
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
    toxic
FROM survey_full
GROUP BY toxic
ORDER BY num_responses DESC;
