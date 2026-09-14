-- Which window actually gets the orders?
-- Night was the largest bucket in this dataset — the opposite of a
-- 9-to-5 support plan.

SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    COUNT(order_id) AS total_orders
FROM instacart.data
GROUP BY time_of_day
ORDER BY total_orders DESC;
