-- How old is each device in the 2024 program year?
-- Age is derived, not stored. Subtracting model_year from 2024
-- makes "newer vs older" a column I can group on later.

SELECT
    *,
    (2024 - model_year) AS device_age
FROM intel.device_data AS d
LEFT JOIN intel.impact_data AS i
    ON d.device_id = i.device_id;
