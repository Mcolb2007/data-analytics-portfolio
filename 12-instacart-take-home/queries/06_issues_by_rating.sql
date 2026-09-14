-- Which reported issues coincide with the lowest ratings?
-- Frequency and average rating are different rankings. Staffing
-- against volume alone would miss the issues that hurt the score.

SELECT
    type_of_issue_reported,
    COUNT(order_id) AS total_occurrences,
    ROUND(AVG(customer_order_rating), 2) AS average_rating
FROM instacart.data
WHERE issue_reported = 1
GROUP BY type_of_issue_reported
ORDER BY average_rating ASC;
