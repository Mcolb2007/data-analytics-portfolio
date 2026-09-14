-- Team-season grain: home win rate and home three-point percentage.
-- 510 rows if grouped by season and team_home.

SELECT
    season,
    team_home,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct
FROM nba.games
GROUP BY season, team_home
ORDER BY season, team_home;
