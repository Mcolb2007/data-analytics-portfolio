-- What is the average ticket, tips included?
SELECT
    AVG(total) AS avg_total_per_order
FROM fastkitchen.orders;
