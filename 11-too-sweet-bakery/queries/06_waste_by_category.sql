-- Waste share by category, still as SUM/SUM so a high-volume day
-- is not averaged away.

SELECT
    product_category,
    SUM(quantity_produced) AS product_sum,
    SUM(quantity_wasted) AS total_wasted,
    ROUND(100 * SUM(quantity_wasted) / SUM(quantity_produced), 2)
        AS total_waste_pct
FROM too_sweet.data
GROUP BY product_category
ORDER BY total_waste_pct DESC;
