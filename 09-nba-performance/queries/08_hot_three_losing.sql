-- Of those hot three-point teams, how many still lost at home?
-- Second HAVING condition. This is the test of whether 37% from
-- three is enough by itself.

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
