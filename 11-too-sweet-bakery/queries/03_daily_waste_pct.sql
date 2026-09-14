-- Daily waste as a share of what was baked, not as a leftover count.
-- SUM(wasted) / SUM(produced) inside the aggregate. AVG of a daily
-- percent would be the wrong grain.

SELECT
    log_date,
    SUM(quantity_produced) AS total_produced,
    SUM(quantity_wasted) AS total_wasted,
    100 * (SUM(quantity_wasted) / SUM(quantity_produced)) AS waste_pct
FROM too_sweet.data
GROUP BY log_date
ORDER BY waste_pct DESC;
