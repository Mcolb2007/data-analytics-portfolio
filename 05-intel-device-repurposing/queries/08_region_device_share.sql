-- Within each region, which device type is doing the work?
-- Two supporting CTEs hold the region totals and the
-- region × type totals so each row can report its share of
-- that region's energy and CO2 savings.

WITH prepped_data AS (
    SELECT
        d.device_id,
        d.device_type,
        i.energy_savings_yr,
        i.co2_saved_kg_yr,
        i.region
    FROM intel.device_data AS d
    LEFT JOIN intel.impact_data AS i
        ON d.device_id = i.device_id
),
region_totals AS (
    SELECT
        region,
        SUM(energy_savings_yr) AS region_total_energy,
        SUM(co2_saved_kg_yr) AS region_total_co2
    FROM prepped_data
    GROUP BY region
),
device_totals AS (
    SELECT
        region,
        device_type,
        COUNT(device_id) AS total_devices,
        AVG(energy_savings_yr) AS avg_energy_savings_kwh,
        AVG(co2_saved_kg_yr) AS avg_co2_saved_kg,
        SUM(energy_savings_yr) AS device_total_energy,
        SUM(co2_saved_kg_yr) AS device_total_co2
    FROM prepped_data
    GROUP BY region, device_type
)
SELECT
    d.region,
    d.device_type,
    d.total_devices,
    ROUND(d.avg_energy_savings_kwh, 2) AS avg_energy_savings_kwh,
    ROUND(d.avg_co2_saved_kg / 1000, 4) AS avg_co2_saved_tons,
    ROUND((d.device_total_energy / r.region_total_energy) * 100, 2)
        AS pct_of_region_energy,
    ROUND((d.device_total_co2 / r.region_total_co2) * 100, 2)
        AS pct_of_region_co2
FROM device_totals AS d
LEFT JOIN region_totals AS r
    ON d.region = r.region
ORDER BY d.region ASC, pct_of_region_energy DESC;
