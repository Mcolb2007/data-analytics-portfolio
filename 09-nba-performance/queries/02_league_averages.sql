-- What should you expect from a random NBA game?
-- AVG(home_team_win) is a win rate, not a point total. 1 = home win,
-- 0 = away win, so the average is the home-court rate.

SELECT
    AVG(pts_home) AS avg_home_score,
    AVG(pts_away) AS avg_away_score,
    AVG(home_team_win) AS avg_home_team_win
FROM nba.games;
