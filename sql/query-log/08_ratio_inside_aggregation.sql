-- Ratios that survive GROUP BY
-- Problem: Too Sweet needs waste as a share of what was baked, not as
-- a count of leftover units.
-- Dataset: too_sweet.data (LiveLab)
-- Why this pattern: AVG(daily waste %) is the wrong grain. Compute
-- SUM(wasted) / SUM(produced) inside the aggregate, then scale to a
-- percent. NULLIF guards a divide-by-zero if a product has no bake
-- volume.

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
        100.0 * SUM(quantity_wasted) / SUM(quantity_produced),
        2
    ) AS waste_pct
FROM too_sweet.data
GROUP BY product
ORDER BY sales_efficiency_pct DESC;
