-- How many orders come from guests?
-- Guest tickets have a NULL user_id. An inner join later would
-- drop this entire group.

SELECT
    COUNT(*) AS guest_orders
FROM fastkitchen.orders
WHERE user_id IS NULL;
