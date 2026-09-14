-- Attach care attributes to each survey row.
-- Join key: survey.plant_types = plant_info.plant.

SELECT *
FROM terracotta.survey AS s
LEFT JOIN terracotta.plant_info AS p
    ON s.plant_types = p.plant;
