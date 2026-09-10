-- Where a device is deployed changes how much carbon it offsets.
-- The same kWh saved on a dirtier grid prevents more CO2.
-- Grouping by region is how that shows up in the data.

WITH prepped_data AS (
    SELECT
        d.device_id,
        i.energy_savings_yr,
        i.co2_saved_kg_yr,
        i.region
    FROM intel.device_data AS d
    LEFT JOIN intel.impact_data AS i
        ON d.device_id = i.device_id
)
SELECT
    region,
    COUNT(device_id) AS total_devices,
    ROUND(AVG(energy_savings_yr), 2) AS avg_energy_savings_kwh,
    ROUND(AVG(co2_saved_kg_yr) / 1000, 4) AS avg_co2_saved_tons
FROM prepped_data
GROUP BY region
ORDER BY total_devices DESC;
