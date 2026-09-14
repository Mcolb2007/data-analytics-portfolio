-- Which issue types are reported, and how often?
-- issue_reported = 1 is the tickets that actually opened a case.

SELECT
    type_of_issue_reported,
    COUNT(order_id) AS frequency
FROM instacart.data
WHERE issue_reported = 1
GROUP BY type_of_issue_reported
ORDER BY frequency DESC;
