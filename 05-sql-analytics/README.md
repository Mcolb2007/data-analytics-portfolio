# SQL analysis: reproducing the findings in a relational database

<img src="../assets/badges/querying-data-sql-intel.png" width="110" align="right" alt="Querying Data badge">

**Files:** [`schema.sql`](schema.sql) · [`queries.sql`](queries.sql) ·
[`build_database.py`](build_database.py) · [`results.md`](results.md)

My SQL certification coursework (Querying Data with Intel) was completed in a browser-based
query environment that does not export, so this project rebuilds that work locally: a real
schema over the same datasets used elsewhere in this portfolio, and twelve queries that
re-answer the questions I had already answered in Python.

**The point of re-implementing them is verification.** If two independent implementations
disagree, one of them is wrong. Every figure below matches its notebook, which is the
strongest evidence I can offer that the numbers are right.

## Running it

```bash
python build_database.py                    # builds gca_portfolio.db from the CSVs
sqlite3 gca_portfolio.db < queries.sql      # runs all twelve queries
```

No database server needed — SQLite ships with Python. Full output is in
[`results.md`](results.md).

## Schema design

Six tables, [`schema.sql`](schema.sql). Three decisions worth explaining:

**Both website feeds live in one `web_traffic` table with a `site` column.** They could have
been two tables, but then every site comparison becomes a `UNION` repeated in each query.
With one table, comparisons are a `GROUP BY`.

**Nullability carries meaning.** `age`, `height`, and `weight` are nullable because they can
legitimately be unknown (75% of pre-1936 Olympic records have no height). Columns an
analysis depends on are `NOT NULL`, so a bad load fails at insert time instead of producing
quietly wrong aggregates.

**`CHECK` constraints encode what I verified in Python.** `sessions > 0`,
`medal IN ('Gold','Silver','Bronze')`, `month BETWEEN 1 AND 12`. The database now refuses
data that contradicts the findings.

## The twelve queries

| # | Question | SQL techniques |
|---|---|---|
| 1 | Awards nights vs regular days | `CASE` inside aggregates, `GROUP BY` |
| 2 | Engagement before and after the split | Derived period labels, ratio aggregation |
| 3 | Like-for-like February–May comparison | CTE, `SUBSTR` date extraction |
| 4 | Awards week as a share of annual traffic | CTE, conditional `SUM` |
| 5 | Age mix per site, side by side | `LEFT JOIN` from a distinct bracket list |
| 6 | Device mix, April–June 2023 | Self-join on date, `BETWEEN` |
| 7 | Olympic medal table | `RANK() OVER`, conditional `SUM` |
| 8 | Sports with the oldest medalists | `HAVING` on an aggregate |
| 9 | Women's share of medalists by decade | Integer division for buckets, `COUNT(DISTINCT)` |
| 10 | Park visit concentration | `ROW_NUMBER()`, `SUM() OVER (ORDER BY …)` running total |
| 11 | Seasonal vs flat park demand | Scalar subquery, derived metrics |
| 12 | Integrity checks | `UNION ALL` assertions |

## Selected results

**Engagement by period** (matches project 01 exactly):

```
┌──────────────────────────────┬──────┬──────────┬─────────────────┬───────────────────┬──────────────────┐
│            period            │ days │ sessions │ bounce_rate_pct │ pages_per_session │ avg_secs_on_site │
├──────────────────────────────┼──────┼──────────┼─────────────────┼───────────────────┼──────────────────┤
│ 1. Combined site (pre-split) │ 1857 │ 80414221 │ 41.58           │ 1.86              │ 102.9            │
│ 2. Grammys site (post-split) │ 485  │ 24220888 │ 40.16           │ 2.25              │ 83.0             │
│ 3. Recording Academy site    │ 485  │ 1168668  │ 33.67           │ 2.78              │ 128.5            │
└──────────────────────────────┴──────┴──────────┴─────────────────┴───────────────────┴──────────────────┘
```

**Park concentration with a running total** — the window function is what turns a sorted
list into the "five sites are 64% of all visits" finding:

```
┌──────┬───────────────────────────────┬───────────────────┬──────────────┬────────────────┐
│ rank │           park_name           │ recreation_visits │ pct_of_total │ cumulative_pct │
├──────┼───────────────────────────────┼───────────────────┼──────────────┼────────────────┤
│ 1    │ Lincoln MEM                   │ 8479349           │ 20.53        │ 20.5           │
│ 2    │ Vietnam Veterans MEM          │ 5295711           │ 12.82        │ 33.4           │
│ 3    │ World War II MEM              │ 5160769           │ 12.5         │ 45.8           │
│ 4    │ Korean War Veterans MEM       │ 4344305           │ 10.52        │ 56.4           │
│ 5    │ Martin Luther King, Jr. MEM   │ 3251594           │ 7.87         │ 64.2           │
└──────┴───────────────────────────────┴───────────────────┴──────────────┴────────────────┘
```

**A finding SQL surfaced more clearly than Python did.** Query 8 uses `HAVING` to filter on
mean age, which turned the Art Competitions observation from project 02 into a ranked list —
and showed it is the extreme case of a broader pattern. The sports with the oldest medalists
are the ones where equipment, animals, or precision matter more than raw physical output:

```
┌──────────────────┬────────┬──────────┬─────────────────┬────────────┬───────────┐
│      sport       │ medals │ mean_age │ oldest_medalist │ first_year │ last_year │
├──────────────────┼────────┼──────────┼─────────────────┼────────────┼───────────┤
│ Art Competitions │ 152    │ 42.3     │ 73.0            │ 1912       │ 1948      │
│ Equestrianism    │ 955    │ 35.4     │ 61.0            │ 1900       │ 2016      │
│ Polo             │ 65     │ 34.6     │ 48.0            │ 1900       │ 1936      │
│ Shooting         │ 1167   │ 33.4     │ 72.0            │ 1896       │ 2016      │
│ Curling          │ 152    │ 33.3     │ 58.0            │ 1924       │ 2014      │
└──────────────────┴────────┴──────────┴─────────────────┴────────────┴───────────┘
```

## Two things I was deliberate about

**Ratio metrics are `SUM(x) / SUM(y)`, never `AVG(x/y)`.** Averaging daily ratios would
weight a 9,000-visitor Tuesday the same as a 3,000,000-visitor awards night. This is the
single easiest way to get a plausible and wrong answer out of correct-looking SQL.

**Join type is a decision, not a default.** Query 6 joins the desktop and mobile feeds with
an `INNER JOIN` on purpose: a date present in only one feed means a collection gap, and
including it would understate the missing segment. Query 5 uses `LEFT JOIN` from a distinct
list of age brackets so a bracket missing from one site still appears as a row rather than
disappearing.

## Integrity checks

Query 12 asserts what must be true before any of the above can be trusted: no non-positive
session counts, no bounced sessions exceeding total sessions, no duplicate site/date pairs.
All return zero.

The one expected non-zero result is `medals_missing_country` = 9 — the same Singapore rows
that [project 02](../02-olympic-medalists/) documents and repairs. I left the check in so the
known gap stays visible instead of being silently patched.

## Skills demonstrated

Schema design with typed, constrained columns · `INNER`/`LEFT`/self joins · CTEs · window
functions (`RANK`, `ROW_NUMBER`, `SUM OVER`) · `GROUP BY`/`HAVING` · `CASE` expressions ·
scalar and correlated subqueries · date handling with `SUBSTR` · data-integrity assertions ·
reproducible ETL in Python
