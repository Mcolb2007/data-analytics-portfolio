-- SkillBuilder 1 Practice — SELECT, FROM, ORDER BY, LIMIT, OFFSET
-- Original Doc: https://docs.google.com/document/d/1CBfEHR3GIiZwnaFlw2BfWo849LL_Ry1wX8cZwRwwVrQ
-- These fill the empty "Paste your query here" boxes. Result counts
-- were never recorded in that Doc — read them from SQL Pad.

-- =============================================================================
-- SELECT & FROM  |  sales_data.cars
-- =============================================================================

-- 1. Return the entire table.
SELECT *
FROM sales_data.cars;

-- 2. How many sales are in the table?
--    Read the row count from SQL Pad's information bar, or:
SELECT COUNT(*) AS n_sales
FROM sales_data.cars;

-- 3. What two regions are in listing_region?
SELECT DISTINCT listing_region
FROM sales_data.cars;

-- 4. Two columns you would need to compare average price by region.
--    (GROUP BY comes in SkillBuilder 3; this is just the columns.)
SELECT listing_region, price
FROM sales_data.cars;

-- 5. Columns for: which manufacturer has the highest average
--    combined city+highway mpg, excluding electric / hybrid.
SELECT make, city_mpg, highway_mpg, engine
FROM sales_data.cars;


-- =============================================================================
-- ORDER BY  |  nba.players  (2019-20)
-- =============================================================================

-- 1. Player names and ages, oldest to youngest.
SELECT name, age
FROM nba.players
ORDER BY age DESC;

-- 2. Who was the oldest player? First row of the query above.
--    Recorded result: run in SQL Pad (not in the original Doc).

-- 3. Is the player with the most three-point attempts the same as
--    the points-per-game leader?
SELECT name, three_pt_attempts, points_per_game
FROM nba.players
ORDER BY three_pt_attempts DESC;

SELECT name, three_pt_attempts, points_per_game
FROM nba.players
ORDER BY points_per_game DESC;

-- 4. Among players with at least 60 games, lowest turnover rate.
--    SkillBuilder 1 has no WHERE yet in the lesson sequence, so the
--    Doc says you may have to scroll. WHERE makes it one query:
SELECT name, games_played, turnover_rate
FROM nba.players
WHERE games_played >= 60
ORDER BY turnover_rate ASC;


-- =============================================================================
-- LIMIT & OFFSET  |  spotify.tracks
-- =============================================================================

-- 1. Artist, track, four audio features; cap at 100 rows.
SELECT
    artist,
    track,
    danceability,
    energy,
    loudness,
    tempo
FROM spotify.tracks
LIMIT 100;

-- 2. Last row of that output should be Armin Van Buuren.
--    Energy rating: read from SQL Pad (not in the original Doc).

-- 3. 100 rows after skipping the first 1,000. Which artist dominates?
SELECT
    artist,
    track,
    danceability,
    energy,
    loudness,
    tempo
FROM spotify.tracks
OFFSET 1000
LIMIT 100;

-- 4. How many of those 100 are NOT that artist?
--    Scan the output, or count once you know the name:
-- SELECT COUNT(*) FROM spotify.tracks OFFSET 1000 LIMIT 100;
-- (COUNT + OFFSET/LIMIT is dialect-dependent; scanning is what the
--  original prompt asked for.)
