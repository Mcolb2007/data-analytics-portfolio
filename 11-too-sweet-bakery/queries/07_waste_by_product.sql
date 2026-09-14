-- Which specific product yields the most waste?
SELECT
    product_category,
    product,
    SUM(quantity_produced) AS product_sum,
    SUM(quantity_wasted) AS total_wasted,
    ROUND(100 * SUM(quantity_wasted) / SUM(quantity_produced), 2)
        AS total_waste_pct
FROM too_sweet.data
GROUP BY product_category, product
ORDER BY total_waste_pct DESC;
