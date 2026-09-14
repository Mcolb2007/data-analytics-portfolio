-- Efficiency and waste on the same row so a product can be both
-- loved and leftover — or neither.

SELECT
    product,
    SUM(quantity_sold) AS total_sold,
    SUM(quantity_produced) AS total_produced,
    SUM(quantity_wasted) AS total_wasted,
    ROUND(
        100.0 * SUM(quantity_sold) / NULLIF(SUM(quantity_produced), 0),
        2
    ) AS sales_efficiency_pct,
    ROUND(
        100 * SUM(quantity_wasted) / SUM(quantity_produced),
        2
    ) AS total_wasted_pct
FROM too_sweet.data
GROUP BY product
ORDER BY sales_efficiency_pct DESC;
