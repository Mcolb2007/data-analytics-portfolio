-- HAVING
-- Problem: Since 2018, how many home teams shot 37% or better from
-- three and still finished below .500 at home?
-- Dataset: nba.games (Milestone 4)
-- Why this pattern: season is a pre-aggregation filter (WHERE).
-- Average three-point rate is a post-aggregation filter (HAVING).
-- Mixing them is the usual bug.

SELECT
    season,
    team_home,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct
FROM nba.games
WHERE season >= '2018'
GROUP BY season, team_home
HAVING AVG(pct_3p_home) >= 0.37
   AND AVG(home_team_win) < 0.5
ORDER BY season, team_home;
