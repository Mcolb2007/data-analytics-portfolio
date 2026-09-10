-- How large is the 2024 program, and what did it save?
-- WITH prepped_data locks the join, age, and buckets once so
-- every later summary uses the same grain.
--
-- CO2 is stored in kg; divide by 1,000 to report tons.

WITH prepped_data AS (
    SELECT
        d.device_id,
        d.device_type,
        d.model_year,
        i.impact_id,
        i.usage_purpose,
        i.power_consumption,
        i.energy_savings_yr,
        i.co2_saved_kg_yr,
        i.recycling_rate,
        i.region,
        (2024 - d.model_year) AS device_age,
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
    COUNT(device_id) AS total_devices_repurposed,
    ROUND(AVG(device_age), 2) AS avg_device_age,
    ROUND(AVG(energy_savings_yr), 2) AS avg_energy_savings_kwh,
    ROUND(SUM(co2_saved_kg_yr) / 1000, 2) AS total_co2_saved_tons
FROM prepped_data;
