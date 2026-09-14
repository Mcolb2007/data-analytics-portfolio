-- Why do customers say they buy? Categories assigned from free text.
SELECT
    reason_for_purchase,
    COUNT(*) AS num_responses
FROM terracotta.survey
GROUP BY reason_for_purchase
ORDER BY num_responses DESC;
