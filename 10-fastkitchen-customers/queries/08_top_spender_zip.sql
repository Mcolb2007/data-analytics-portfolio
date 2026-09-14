-- Which zip does the highest-spending registered user live in?
-- Filter to matched users after the join so guest rows (NULL user_id)
-- are not treated as a fake customer.

SELECT
    users.zip,
    users.user_id,
    SUM(orders.total) AS total_spent
FROM fastkitchen.orders
LEFT JOIN fastkitchen.users
    ON orders.user_id = users.user_id
WHERE users.user_id IS NOT NULL
GROUP BY users.user_id, users.zip
ORDER BY total_spent DESC
LIMIT 1;
