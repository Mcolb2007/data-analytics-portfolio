-- Home team-season summary table: points, three-point rate, wins.
-- SUM(home_team_win) is a win count because the flag is 1/0.

SELECT
    season,
    team_home,
    AVG(pts_home) AS avg_home_pts,
    AVG(pct_3p_home) AS avg_home_3p_pct,
    SUM(home_team_win) AS home_wins
FROM nba.games
GROUP BY season, team_home
ORDER BY season, team_home;
