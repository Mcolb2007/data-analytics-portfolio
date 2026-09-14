-- How often do customers buy plants?
-- SkillBuilder 3 GROUP BY. Terracotta LevelUp box was empty.

SELECT
    freq,
    COUNT(*) AS num_responses
FROM terracotta.survey
GROUP BY freq
ORDER BY num_responses DESC;
