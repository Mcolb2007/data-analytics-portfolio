-- Production and waste on the same day grain.
SELECT
    log_date,
    SUM(quantity_produced) AS total_produced,
    SUM(quantity_wasted) AS total_wasted
FROM too_sweet.data
GROUP BY log_date;
