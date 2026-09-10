-- LEFT JOIN
-- Problem: FastKitchen wants order value by zip code, including guests
-- who never created an account.
-- Dataset: fastkitchen.orders, fastkitchen.users (Milestone 5)
-- Why this pattern: guest orders have a NULL user_id. An inner join
-- would drop them and make registered customers look like the whole
-- business. LEFT JOIN from orders keeps every ticket; the zip filter
-- is applied after the join when the question is only about registered
-- spend.

SELECT
    users.zip,
    AVG(orders.total) AS average_order_total
FROM fastkitchen.orders
LEFT JOIN fastkitchen.users
    ON orders.user_id = users.user_id
WHERE users.zip IS NOT NULL
GROUP BY users.zip
ORDER BY average_order_total DESC;
