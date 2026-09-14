-- SkillBuilder 4 Practice — DATE_PART / EXTRACT grouped on time
-- Original Doc: https://docs.google.com/document/d/1tDg95kgSYh5EgRDAvEAt4EMdJ-iLmGZDsOB7kV7CJio
-- Answers below are from the official solutions Doc:
-- https://docs.google.com/document/d/1rsW7ZzuQ7SJwRgXhBFxCjb5VPuy9gXqtBWE5_HONPtM

-- =============================================================================
-- GROUP BY on datetime  |  lyft.baywheels
-- =============================================================================

-- 1. In which month were the most trips taken?
--    Look at the month part of started_date.
SELECT
    DATE_PART('month', started_date) AS month,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY month
ORDER BY n_trips DESC;
-- Official solution: October 2020, 167,210 rentals
-- (the last month in the extract). You could ORDER BY month
-- instead to see volume over time.

-- 2. During what hour of the day do the most rentals take place?
--    started_at is the timestamp; started_date is the date.
SELECT
    DATE_PART('hour', started_at) AS hour_of_day,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY hour_of_day
ORDER BY n_trips DESC;
-- Official solution: 5pm hour is highest (98,661), 6pm second (89,579).

-- Same idea with EXTRACT, which is what the Instacart project uses:
SELECT
    EXTRACT(HOUR FROM started_at) AS hour_of_day,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY hour_of_day
ORDER BY n_trips DESC;

-- 3. Trips by day of week. 0 = Sunday, 6 = Saturday.
--    started_date has year/month/day; DATE_PART('dow', ...) pulls weekday.
SELECT
    DATE_PART('dow', started_date) AS day_of_week,
    COUNT(*) AS n_trips
FROM lyft.baywheels
GROUP BY day_of_week
ORDER BY day_of_week ASC;
-- Official solution: more trips on weekends than weekdays.
-- Saturday is the peak. Friday and Sunday are similar.
-- Monday is the trough; volume ramps up through the week.
