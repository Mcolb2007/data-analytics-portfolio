-- Restrict to 2018 onward before aggregating.
-- season is text in this table, so the cutoff is quoted: '2018'.
-- WHERE filters rows; it cannot filter an AVG(...).

SELECT
    season,
    team_home,
    AVG(home_team_win) AS home_team_win_rate,
    AVG(pct_3p_home) AS avg_home_3p_pct
FROM nba.games
WHERE season >= '2018'
GROUP BY season, team_home
ORDER BY season, team_home;
