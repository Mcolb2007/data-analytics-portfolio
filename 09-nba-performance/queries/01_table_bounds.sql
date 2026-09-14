-- How many games, and which seasons, are in this table?
-- One query, three facts: COUNT(*), MIN(season), MAX(season).

SELECT
    COUNT(*) AS total_games,
    MIN(season) AS first_season,
    MAX(season) AS last_season
FROM nba.games;
