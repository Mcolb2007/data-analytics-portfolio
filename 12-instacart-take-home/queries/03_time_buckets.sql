-- Turn 24 hours into Morning / Afternoon / Evening / Night.
-- BETWEEN 5 AND 11 is 5 AM–11:59 AM in this extract.

SELECT
    order_id,
    order_date,
    EXTRACT(HOUR FROM order_date) AS order_hour,
    CASE
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day
FROM instacart.data;
