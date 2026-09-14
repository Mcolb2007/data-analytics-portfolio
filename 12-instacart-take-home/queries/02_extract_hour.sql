-- Pull the hour from the timestamp so 24 values can become four windows.
SELECT
    order_id,
    order_date,
    EXTRACT(HOUR FROM order_date) AS order_hour
FROM instacart.data;
