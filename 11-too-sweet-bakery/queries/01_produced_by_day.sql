-- Total goods produced each day.
-- The starter query grouped by date but never summed production.

SELECT
    log_date,
    SUM(quantity_produced) AS total_produced
FROM too_sweet.data
GROUP BY log_date;
