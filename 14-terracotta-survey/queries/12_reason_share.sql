-- Share of the survey that listed each purchase reason.
-- SkillBuilder 3 COUNT + SkillBuilder 4 ROUND. The original lab
-- asked for care-requirements % and pet-safety % using 217 as the
-- denominator. This query returns every reason's share so those two
-- can be read off the output without a calculator.

SELECT
    reason_for_purchase,
    COUNT(*) AS num_responses,
    ROUND(100.0 * COUNT(*) / 217, 1) AS pct_of_survey
FROM terracotta.survey
GROUP BY reason_for_purchase
ORDER BY num_responses DESC;
