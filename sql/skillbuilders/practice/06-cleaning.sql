-- SkillBuilder 6 — concatenation, UPPER/LOWER, CASE WHEN
-- No SkillBuilder 6 Practice Doc was in Drive. Summary examples,
-- plus the CASE WHEN pattern used for Instacart staffing windows.

-- =============================================================================
-- Summary examples
-- =============================================================================

-- Concatenate first + last name.
SELECT
    appt_start_date,
    firstname || ' ' || lastname AS full_name
FROM wh_visits.data2016a;

-- Unique names, forced uppercase.
SELECT DISTINCT
    UPPER(firstname) || ' ' || UPPER(lastname) AS full_name
FROM wh_visits.data2016a;

-- Bucket a product description into bike types.
-- Wildcards added so ILIKE matches a description that *contains*
-- the word, not only a description that equals it.
SELECT
    *,
    CASE
        WHEN product ILIKE '%road%' THEN 'Road'
        WHEN product ILIKE '%mountain%' THEN 'Mountain'
        WHEN product ILIKE '%touring%' THEN 'Touring'
    END AS bike_type
FROM sales_data.bikes
WHERE product_category = 'Bikes';


-- =============================================================================
-- Same pattern in the portfolio — Instacart time windows (project 12)
-- =============================================================================

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
