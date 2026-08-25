-- ============================================================================
-- SQL analysis of the portfolio datasets
-- Maurice Colbert Jr.
--
-- Each query below answers a question I had already answered in Python
-- elsewhere in this portfolio. Re-deriving the same numbers in SQL is a
-- deliberate check: if the two implementations disagree, one of them is wrong.
-- Every result here matches the corresponding notebook.
--
-- Run with:  sqlite3 gca_portfolio.db < queries.sql
-- (Run `python build_database.py` first.)
-- ============================================================================

.mode box
.headers on


-- ----------------------------------------------------------------------------
-- Q1. How concentrated is Grammys traffic on awards nights?
--
-- Why CASE instead of two queries: putting the awards-night flag inside an
-- aggregate lets me compute both groups in one pass and place them side by
-- side, which is what makes the ratio readable.
-- ----------------------------------------------------------------------------
SELECT 'Q1. Awards nights vs regular days (grammy.com)' AS query;

SELECT
    CASE awards_night WHEN 1 THEN 'Awards night' ELSE 'Regular day' END AS day_type,
    COUNT(*)                                                            AS days,
    ROUND(AVG(visitors))                                                AS avg_visitors,
    ROUND(100.0 * SUM(bounced_sessions) / SUM(sessions), 2)             AS bounce_rate_pct,
    ROUND(1.0 * SUM(pageviews) / SUM(sessions), 2)                      AS pages_per_session,
    ROUND(AVG(avg_session_duration_secs), 1)                            AS avg_secs_on_site
FROM web_traffic
WHERE site = 'grammys'
GROUP BY awards_night
ORDER BY awards_night DESC;


-- ----------------------------------------------------------------------------
-- Q2. Did engagement improve after the February 1, 2022 site split?
--
-- Ratio metrics are computed as SUM(x) / SUM(y), never AVG of a per-row ratio.
-- Averaging daily ratios would weight a 9,000-visitor Tuesday the same as a
-- 3,000,000-visitor awards night.
-- ----------------------------------------------------------------------------
SELECT 'Q2. Engagement before and after the split' AS query;

SELECT
    CASE
        WHEN site = 'grammys' AND date <  '2022-02-01' THEN '1. Combined site (pre-split)'
        WHEN site = 'grammys' AND date >= '2022-02-01' THEN '2. Grammys site (post-split)'
        ELSE                                                '3. Recording Academy site'
    END                                                     AS period,
    COUNT(*)                                                AS days,
    SUM(sessions)                                           AS sessions,
    ROUND(100.0 * SUM(bounced_sessions) / SUM(sessions), 2) AS bounce_rate_pct,
    ROUND(1.0 * SUM(pageviews) / SUM(sessions), 2)          AS pages_per_session,
    ROUND(AVG(avg_session_duration_secs), 1)                AS avg_secs_on_site
FROM web_traffic
GROUP BY period
ORDER BY period;


-- ----------------------------------------------------------------------------
-- Q3. The same comparison restricted to matching calendar months.
--
-- The pre-split window covers five full years while the post-split window
-- covers sixteen months, so awards season is over-represented after the split.
-- Filtering both sides to February-May controls for that seasonality. This is
-- the comparison I trust, and it is where the Academy site's awards-season
-- bounce problem shows up.
-- ----------------------------------------------------------------------------
SELECT 'Q3. Like-for-like: February-May only' AS query;

WITH feb_to_may AS (
    SELECT *,
           CAST(SUBSTR(date, 1, 4) AS INTEGER) AS yr,
           CAST(SUBSTR(date, 6, 2) AS INTEGER) AS mo
    FROM web_traffic
)
SELECT
    CASE
        WHEN site = 'grammys' AND yr <= 2021 THEN 'Combined site, Feb-May 2017-21'
        WHEN site = 'grammys'                THEN 'Grammys site, Feb-May 2022-23'
        ELSE                                      'Academy site, Feb-May 2022-23'
    END                                                     AS period,
    COUNT(*)                                                AS days,
    ROUND(100.0 * SUM(bounced_sessions) / SUM(sessions), 2) AS bounce_rate_pct,
    ROUND(1.0 * SUM(pageviews) / SUM(sessions), 2)          AS pages_per_session,
    ROUND(AVG(avg_session_duration_secs), 1)                AS avg_secs_on_site
FROM feb_to_may
WHERE mo BETWEEN 2 AND 5
GROUP BY period
ORDER BY period;


-- ----------------------------------------------------------------------------
-- Q4. Awards week as a share of each year's traffic.
--
-- A window function gives me the yearly total alongside each row, so the share
-- is one division instead of a self-join back to a grouped subquery.
-- ----------------------------------------------------------------------------
SELECT 'Q4. Share of annual traffic arriving during awards week' AS query;

WITH yearly AS (
    SELECT
        SUBSTR(date, 1, 4)                                   AS yr,
        SUM(visitors)                                        AS visitors,
        SUM(CASE WHEN awards_week = 1 THEN visitors ELSE 0 END) AS awards_week_visitors
    FROM web_traffic
    WHERE site = 'grammys'
    GROUP BY yr
)
SELECT
    yr                                                            AS year,
    awards_week_visitors,
    visitors                                                      AS total_visitors,
    ROUND(100.0 * awards_week_visitors / visitors, 1)             AS pct_from_awards_week
FROM yearly
ORDER BY yr;


-- ----------------------------------------------------------------------------
-- Q5. Do the two sites reach different age groups?
--
-- A self-join on age_group puts the two sites in one row so the difference is
-- directly visible. The FULL OUTER JOIN pattern is emulated with a LEFT JOIN
-- from a distinct bracket list, because SQLite historically lacked FULL OUTER
-- JOIN and this keeps the query portable.
-- ----------------------------------------------------------------------------
SELECT 'Q5. Age mix, side by side' AS query;

WITH brackets AS (SELECT DISTINCT age_group FROM age_demographics)
SELECT
    b.age_group,
    ROUND(g.pct_visitors, 2)                    AS grammys_pct,
    ROUND(a.pct_visitors, 2)                    AS academy_pct,
    ROUND(a.pct_visitors - g.pct_visitors, 2)   AS difference_pp
FROM brackets b
LEFT JOIN age_demographics g ON g.age_group = b.age_group AND g.site = 'grammys'
LEFT JOIN age_demographics a ON a.age_group = b.age_group AND a.site = 'recording_academy'
ORDER BY b.age_group;


-- ----------------------------------------------------------------------------
-- Q6. Mobile share of Grammys traffic, April-June 2023.
--
-- The two device feeds arrive as separate rows, so this joins them on date. I
-- used an INNER JOIN deliberately: a date present in only one feed would mean a
-- collection gap, and including it would understate the missing segment.
-- ----------------------------------------------------------------------------
SELECT 'Q6. Device mix, Apr-Jun 2023' AS query;

SELECT
    COUNT(*)                                                        AS days,
    SUM(d.visitors + m.visitors)                                    AS total_visitors,
    ROUND(100.0 * SUM(d.visitors) / SUM(d.visitors + m.visitors), 2) AS desktop_pct,
    ROUND(100.0 * SUM(m.visitors) / SUM(d.visitors + m.visitors), 2) AS mobile_pct
FROM device_traffic d
JOIN device_traffic m ON m.date = d.date AND m.segment = 'mobile'
WHERE d.segment = 'desktop'
  AND d.date BETWEEN '2023-04-01' AND '2023-06-30';


-- ----------------------------------------------------------------------------
-- Q7. Olympic medal table with ranking.
--
-- RANK() over the medal total is what turns a sorted list into an actual medal
-- table, and it handles ties correctly instead of assigning arbitrary positions.
-- ----------------------------------------------------------------------------
SELECT 'Q7. Top 10 countries by total medals' AS query;

WITH totals AS (
    SELECT
        country,
        COUNT(*)                                          AS total_medals,
        SUM(CASE WHEN medal = 'Gold'   THEN 1 ELSE 0 END) AS gold,
        SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS silver,
        SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze
    FROM olympic_medals
    WHERE country IS NOT NULL
    GROUP BY country
)
SELECT
    RANK() OVER (ORDER BY total_medals DESC) AS rank,
    country,
    total_medals,
    gold,
    silver,
    bronze,
    ROUND(100.0 * gold / total_medals, 1)    AS gold_pct
FROM totals
ORDER BY total_medals DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- Q8. The Art Competitions finding, in SQL.
--
-- HAVING filters on the aggregate (mean age), which a WHERE clause cannot do.
-- This surfaces the sports whose medalists are meaningfully older than the
-- overall mean of 25.9 — the pattern that led to the story in project 02.
-- ----------------------------------------------------------------------------
SELECT 'Q8. Sports whose medalists are oldest (min 30 medals)' AS query;

SELECT
    sport,
    COUNT(*)                 AS medals,
    ROUND(AVG(age), 1)       AS mean_age,
    MAX(age)                 AS oldest_medalist,
    MIN(year)                AS first_year,
    MAX(year)                AS last_year
FROM olympic_medals
WHERE age IS NOT NULL
GROUP BY sport
HAVING COUNT(*) >= 30 AND AVG(age) > 30
ORDER BY mean_age DESC
LIMIT 10;


-- ----------------------------------------------------------------------------
-- Q9. Women's share of medalists by decade.
--
-- Integer division on the year builds the decade bucket without a calendar
-- table. This is the trend line behind the "festival to professional sport"
-- argument in project 02.
-- ----------------------------------------------------------------------------
SELECT 'Q9. Womens share of medalists by decade' AS query;

SELECT
    (year / 10) * 10                                            AS decade,
    COUNT(*)                                                    AS medals,
    SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END)                  AS medals_won_by_women,
    ROUND(100.0 * SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_women,
    COUNT(DISTINCT event)                                       AS distinct_events
FROM olympic_medals
GROUP BY decade
ORDER BY decade;


-- ----------------------------------------------------------------------------
-- Q10. National park concentration, with a running cumulative share.
--
-- SUM() OVER with an ORDER BY produces the running total, which is what shows
-- that five sites reach 64% of all visits. Doing this without a window function
-- would need a correlated subquery per row.
-- ----------------------------------------------------------------------------
SELECT 'Q10. DC park visit concentration' AS query;

SELECT
    ROW_NUMBER() OVER (ORDER BY recreation_visits DESC) AS rank,
    park_name,
    recreation_visits,
    ROUND(100.0 * recreation_visits / SUM(recreation_visits) OVER (), 2) AS pct_of_total,
    ROUND(100.0 * SUM(recreation_visits) OVER (ORDER BY recreation_visits DESC)
          / SUM(recreation_visits) OVER (), 1)                          AS cumulative_pct
FROM park_visits
ORDER BY recreation_visits DESC
LIMIT 8;


-- ----------------------------------------------------------------------------
-- Q11. Seasonal vs non-seasonal park demand.
--
-- The comparison that matters for campaign planning: recreation visits swing
-- 3.6x across the year while non-recreation traffic is essentially flat, so
-- only one of these two is worth advertising against.
-- ----------------------------------------------------------------------------
SELECT 'Q11. Monthly park demand, seasonal vs flat' AS query;

SELECT
    month,
    recreation_visits,
    non_recreation_visits,
    ROUND(1.0 * recreation_visits
          / (SELECT MIN(recreation_visits) FROM park_monthly), 2) AS x_vs_quietest_month,
    ROUND(60.0 * recreation_hours / recreation_visits, 1)         AS avg_minutes_per_visit
FROM park_monthly
ORDER BY recreation_visits DESC;


-- ----------------------------------------------------------------------------
-- Q12. Data-quality check I would run before trusting any of the above.
--
-- Rather than assuming the load was clean, this asserts the things that must be
-- true: no negative counts, bounced sessions never exceed sessions, and no
-- duplicate site/date pairs. Those must all return 0.
--
-- `medals_missing_country` is the one expected non-zero result: it returns the
-- same 9 Singapore rows that project 02 documents and repairs. I keep it in the
-- check so the known gap stays visible instead of being silently patched.
-- ----------------------------------------------------------------------------
SELECT 'Q12. Integrity checks (0 expected, except the documented Singapore rows)' AS query;

SELECT 'negative_or_zero_sessions' AS check_name,
       COUNT(*) AS failing_rows FROM web_traffic WHERE sessions <= 0
UNION ALL
SELECT 'bounces_exceed_sessions',
       COUNT(*) FROM web_traffic WHERE bounced_sessions > sessions
UNION ALL
SELECT 'duplicate_site_dates',
       (SELECT COUNT(*) FROM (SELECT site, date FROM web_traffic
                              GROUP BY site, date HAVING COUNT(*) > 1))
UNION ALL
SELECT 'medals_missing_country',
       COUNT(*) FROM olympic_medals WHERE country IS NULL
UNION ALL
SELECT 'parks_with_zero_visits',
       COUNT(*) FROM park_visits WHERE recreation_visits <= 0;
