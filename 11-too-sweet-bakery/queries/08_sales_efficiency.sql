-- Sales efficiency: how much of what was baked actually sold.
-- NULLIF guards a divide-by-zero if a product has no bake volume.

SELECT
    product,
    SUM(quantity_sold) AS total_sold,
    SUM(quantity_produced) AS total_produced,
    ROUND(
        100.0 * SUM(quantity_sold) / NULLIF(SUM(quantity_produced), 0),
        2
    ) AS sales_efficiency_pct
FROM too_sweet.data
GROUP BY product
ORDER BY sales_efficiency_pct DESC;
