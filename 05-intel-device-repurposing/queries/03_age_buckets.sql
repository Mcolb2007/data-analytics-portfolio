-- Raw age is too granular for a strategy call. Three buckets
-- (newer / mid-age / older) are enough to compare volume against
-- per-device savings without drowning in 15 individual years.
--
-- The CASE has to recompute (2024 - d.model_year) rather than
-- reference the alias device_age — SQL evaluates SELECT aliases
-- after WHERE/CASE in this environment.

SELECT
    *,
    (2024 - model_year) AS device_age,
    CASE
        WHEN (2024 - d.model_year) <= 3 THEN 'newer'
        WHEN (2024 - d.model_year) > 3
             AND (2024 - d.model_year) <= 6 THEN 'mid-age'
        WHEN (2024 - d.model_year) > 6 THEN 'older'
    END AS device_age_bucket
FROM intel.device_data AS d
LEFT JOIN intel.impact_data AS i
    ON d.device_id = i.device_id
ORDER BY d.model_year ASC;
