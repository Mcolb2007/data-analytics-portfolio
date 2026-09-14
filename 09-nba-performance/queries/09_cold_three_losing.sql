-- Flip the three-point cut: 34% or worse, and a losing home record.
-- Compare the row count to 08. If three-point shooting were
-- unrelated to winning, these two lists should be similar sizes.

SELECT
    season,
    team_home,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct
FROM nba.games
WHERE season >= '2018'
GROUP BY season, team_home
HAVING AVG(pct_3p_home) <= 0.34
   AND AVG(home_team_win) < 0.5
ORDER BY season, team_home;
