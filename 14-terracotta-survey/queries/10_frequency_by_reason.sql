-- Do weekly buyers care about the same things as once-a-year buyers?
-- SkillBuilder 3: GROUP BY two columns.

SELECT
    freq,
    reason_for_purchase,
    COUNT(*) AS num_responses
FROM terracotta.survey
GROUP BY freq, reason_for_purchase
ORDER BY freq, num_responses DESC;
