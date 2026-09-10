-- Is Intel collecting the devices that save the most energy,
-- or the devices that are easiest to collect?
-- Grouping by age bucket answers that directly: volume and
-- per-device savings move in opposite directions.

WITH prepped_data AS (
    SELECT
        d.device_id,
        d.device_type,
        i.energy_savings_yr,
        i.co2_saved_kg_yr,
        CASE
            WHEN (2024 - d.model_year) <= 3 THEN 'newer'
            WHEN (2024 - d.model_year) > 3
                 AND (2024 - d.model_year) <= 6 THEN 'mid-age'
            WHEN (2024 - d.model_year) > 6 THEN 'older'
        END AS device_age_bucket
    FROM intel.device_data AS d
    LEFT JOIN intel.impact_data AS i
        ON d.device_id = i.device_id
)
SELECT
    device_age_bucket,
    COUNT(device_id) AS total_devices,
    ROUND(AVG(energy_savings_yr), 2) AS avg_energy_savings_kwh,
    ROUND(AVG(co2_saved_kg_yr) / 1000, 4) AS avg_co2_saved_tons
FROM prepped_data
GROUP BY device_age_bucket;
