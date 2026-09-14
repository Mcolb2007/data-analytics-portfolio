-- How many team-seasons since 2018 shot 37% or better from three at home?
-- HAVING filters the aggregated rate. WHERE cannot see AVG(pct_3p_home).

SELECT
    season,
    team_home,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct
FROM nba.games
WHERE season >= '2018'
GROUP BY season, team_home
HAVING AVG(pct_3p_home) >= 0.37
ORDER BY season, team_home;
