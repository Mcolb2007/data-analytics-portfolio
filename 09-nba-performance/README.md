# Does a hot three-point rate win home games?

A coaching staff wanted a seventeen-season read of NBA team
performance: scoring, home-court advantage, and whether three-point
shooting is actually tied to winning. The table is `nba.games` —
**23,335** games from the **2004** season through **2020**.

The queries in [`queries/`](queries/) are the ones I wrote. Row counts
and rates below are what I recorded from the course SQL app.

## Home-court is real. It is also shrinking.

`AVG(home_team_win)` is a win rate because the column is a 1/0 flag.

[`01_table_bounds.sql`](queries/01_table_bounds.sql) ·
[`02_league_averages.sql`](queries/02_league_averages.sql)

Across the whole table, a random game is a **home win about 59%** of
the time. Grouped by season, **home and away scores have gone up**
while the **home win rate has gone down**. Three-point percentage for
both sides has gone up with scoring.

[`03_by_season.sql`](queries/03_by_season.sql) ·
[`04_three_point_by_season.sql`](queries/04_three_point_by_season.sql)

One explanation I considered for the fading home-court edge: improved
travel and recovery, so road teams are less fatigued.

## Finding — 37% from three is common; losing with it is not

League three-point rate over the whole table is about **35.4%**. I
moved to a team-season grain, then cut to **2018 onward** (`season` is
text in this table, so the cutoff is `'2018'`).

`WHERE` filters rows before the aggregate. `HAVING` filters the
aggregate. Mixing them is the usual bug.

```sql
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
```

[`07_hot_three.sql`](queries/07_hot_three.sql) ·
[`08_hot_three_losing.sql`](queries/08_hot_three_losing.sql) ·
[`09_cold_three_losing.sql`](queries/09_cold_three_losing.sql)

| Filter (2018 onward, home games) | Team-seasons I recorded |
|---|---|
| Average 3P% ≥ 37% | **25** |
| …and a losing home record (< .500) | **2** |
| Average 3P% ≤ 34% and a losing home record | **7** |

Hot three-point teams almost always have a winning home record. Cold
three-point teams show up more often on the losing list. The lower
the shot rate, the less likely the team is to win — but two teams
still lost at home while shooting 37%+, so three-point shooting is
not the whole sport.

Teams that do not live on the three rely on **defense, points in the
post, and extra rebounds for second-chance points**. Those metrics
are the next place I would look.

## The LevelUp — a summary table you can join later

[`10_home_summary.sql`](queries/10_home_summary.sql) ·
[`11_away_summary.sql`](queries/11_away_summary.sql)

Home wins are `SUM(home_team_win)`. Away wins have to be derived:
`SUM(1 - home_team_win)`, because the table never stores an away-win
flag. That is the kind of grain you build before a join, not after.

## Recommendation

1. Treat **three-point accuracy as a winning correlate, not a
   complete strategy.** 25 hot-shooting team-seasons, only 2 losers.
2. Do not ignore the **7** losing team-seasons at 34% or worse — that
   is the cost of a cold three if you have no other identity.
3. Track defense, paint scoring, and rebounding before you tell a
   staff that 37% from three is the plan.

## Limitations

- Team-season counts (25 / 2 / 7) were read from the SQL app row
  count, not returned as a `COUNT` in the query.
- Home-court decline is a seasonal trend, not a causal model. Travel
  and recovery is one explanation, not a measured one.
- Franchise names in the table are current names even for older
  seasons.

## How I used AI on this project

I wrote the `HAVING` queries and recorded 25 / 2 / 7 team-seasons
myself. The original lab asked ChatGPT why home-court advantage might
be fading, and what winning teams do besides shoot threes; travel /
recovery and paint-and-defense are the explanations I kept. Cursor
packaged the Google Doc into this folder without changing those details.

## Skills demonstrated

`COUNT` / `MIN` / `MAX` in one query · `AVG` of a 1/0 flag as a rate ·
`GROUP BY` season and team · `WHERE` vs `HAVING` · derived away wins
(`1 - home_team_win`) · testing whether a "hot" metric actually
separates winners from losers

## Data

GCA Querying Data track. Table: `nba.games`, 2004–2020. The course
SQL app is not public, so this folder ships the queries and the
result totals I recorded rather than a copy of the table.
