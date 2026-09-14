-- Did three-point accuracy rise with scoring?
-- Same seasonal grain, two more averages.

SELECT
    season,
    AVG(pts_home) AS avg_home_score,
    AVG(pts_away) AS avg_away_score,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct,
    AVG(pct_3p_away) AS avg_away_3p_pct
FROM nba.games
GROUP BY season
ORDER BY season;
