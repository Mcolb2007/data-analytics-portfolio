-- Do onsite, carryout, and delivery spend differently?
SELECT
    order_type,
    AVG(subtotal) AS avg_subtotal,
    AVG(tip) AS avg_tip,
    AVG(total) AS avg_total
FROM fastkitchen.orders
GROUP BY order_type
ORDER BY order_type;
