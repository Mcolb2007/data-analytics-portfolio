-- Away team-season summary.
-- The table only flags whether the home team won. Away wins are
-- SUM(1 - home_team_win).

SELECT
    season,
    team_away,
    AVG(pts_away) AS avg_away_pts,
    AVG(pct_3p_away) AS avg_away_3p_pct,
    SUM(1 - home_team_win) AS away_wins
FROM nba.games
GROUP BY season, team_away
ORDER BY season, team_away;
