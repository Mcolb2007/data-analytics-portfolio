-- How many orders come from registered accounts?
-- user_id IS NOT NULL is the registered grain.
SELECT
    COUNT(*) AS registered_user_orders
FROM fastkitchen.orders
WHERE user_id IS NOT NULL;
