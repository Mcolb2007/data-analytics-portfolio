-- Have scoring and home-court advantage moved together over time?
-- GROUP BY season. Chronological ORDER BY so a trend is visible.

SELECT
    season,
    AVG(pts_home) AS avg_home_score,
    AVG(pts_away) AS avg_away_score,
    AVG(home_team_win) AS home_team_win_rate
FROM nba.games
GROUP BY season
ORDER BY season;
