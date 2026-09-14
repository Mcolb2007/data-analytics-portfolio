-- Average order value by zip, registered customers only.
-- users.zip IS NOT NULL after a LEFT JOIN is the registered slice.

SELECT
    users.zip,
    AVG(orders.total) AS average_order_total
FROM fastkitchen.orders
LEFT JOIN fastkitchen.users
    ON orders.user_id = users.user_id
WHERE users.zip IS NOT NULL
GROUP BY users.zip
ORDER BY average_order_total DESC;
