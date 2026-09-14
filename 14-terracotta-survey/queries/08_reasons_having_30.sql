-- How many reason categories reached at least 30 responses?
-- HAVING filters the grouped count. The outer query counts how
-- many categories cleared the bar.

SELECT
    COUNT(*) AS categories_with_30_plus
FROM (
    SELECT
        reason_for_purchase,
        COUNT(*) AS num_responses
    FROM terracotta.survey
    GROUP BY reason_for_purchase
    HAVING COUNT(*) >= 30
) AS filtered_categories;
