-- Which devices were actually repurposed in 2024?
-- LEFT JOIN keeps every device even if an impact record is missing.
-- An inner join would silently drop devices with no impact row and
-- understate the size of the program.

SELECT *
FROM intel.device_data AS d
LEFT JOIN intel.impact_data AS i
    ON d.device_id = i.device_id;
