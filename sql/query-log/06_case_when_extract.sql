-- CASE WHEN and EXTRACT
-- Problem: When do Instacart orders actually land, in language a
-- staffing plan can use?
-- Dataset: instacart.data (LiveLab take-home)
-- Why this pattern: EXTRACT pulls the hour; CASE WHEN turns 24 hours
-- into four windows a support manager can staff against. Night was
-- the largest bucket in this dataset — the opposite of a 9-to-5 plan.

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
