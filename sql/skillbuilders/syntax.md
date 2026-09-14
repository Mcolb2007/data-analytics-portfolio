# SkillBuilder syntax recap

Copied from the GCA **SkillBuilder Summary** so I can relearn without
opening Drive. Examples use the course warehouse tables.

Pro tip from the original Doc: run these in
[SQL Pad](https://sql.hq.globaltech.org/queries/new) and look at the
output, not just the syntax.

## SkillBuilder 1 — Querying

**SELECT / FROM** — all columns, or named columns.

```sql
SELECT * FROM library.san_francisco;

SELECT age_range, total_checkouts, total_renewals
FROM library.san_francisco;
```

**LIMIT** — cap the result (a top-10 list).

```sql
SELECT * FROM library.san_francisco LIMIT 10;
```

**OFFSET** — skip rows, usually with LIMIT.

```sql
SELECT propertyid, saleamount
FROM zillow.transactions
OFFSET 20;
```

**ORDER BY** — `ASC` is optional; `DESC` is largest first.

```sql
SELECT * FROM zillow.transactions ORDER BY saleamount ASC;
SELECT * FROM zillow.transactions ORDER BY saleamount DESC;
```

## SkillBuilder 2 — Filtering

**WHERE** — keep rows that match.

```sql
SELECT * FROM airbnb.listings WHERE room_type = 'Private room';
```

**BETWEEN** — inclusive range.

```sql
SELECT year_film, year_ceremony, name, film
FROM oscars.nominees
WHERE year_film BETWEEN 2000 AND 2010;
```

**IN** — list of values.

```sql
SELECT year_film, year_ceremony, name, film
FROM oscars.nominees
WHERE name IN ('Emma Stone', 'Margot Robbie', 'Jennifer Lawrence');
```

**LIKE** — case-sensitive pattern. `%` is any characters.

```sql
SELECT name FROM oscars.nominees WHERE name LIKE 'M%';
SELECT * FROM oscars.nominees WHERE film LIKE '%Love%';
```

**ILIKE** — same, case-insensitive. `ILIKE '%Love%'` also matches
Beloved, Clover, Strangelove.

```sql
SELECT * FROM oscars.nominees WHERE film ILIKE '%Love%';
SELECT * FROM oscars.nominees WHERE category ILIKE 'music%';
```

**IS NULL / IS NOT NULL** — missing vs known.

```sql
SELECT * FROM imdb.data WHERE budget IS NULL;
SELECT * FROM imdb.data WHERE budget IS NOT NULL;
```

**AND / OR / NOT** — combine conditions. Parentheses decide order.

```sql
SELECT * FROM imdb.data
WHERE movie_title LIKE '%House%' AND gross >= 100000000;

SELECT * FROM imdb.data
WHERE title_year < 2000 OR imdb_score > 8.5;

SELECT * FROM imdb.data
WHERE budget > 50000000 AND NOT gross > budget * 2;
```

## SkillBuilder 3 — Aggregating

**COUNT(column)** — non-NULL values. **COUNT(*)** — rows, including NULL.

```sql
SELECT COUNT(state) FROM election.state_results WHERE year = 2016;
SELECT COUNT(*) FROM election.state_results;
```

**SUM / MIN / MAX**

```sql
SELECT
    SUM(democratic_votes) AS dem_votes,
    SUM(republican_votes) AS rep_votes
FROM election.state_results
WHERE year = 2016;

SELECT MIN(democratic_votes)
FROM election.state_results
WHERE year = 2016;
```

**GROUP BY** — one row per shared value.

```sql
SELECT
    state,
    SUM(democratic_votes) AS dem_votes,
    SUM(republican_votes) AS rep_votes
FROM election.state_results
GROUP BY state;
```

## SkillBuilder 4 — Filtering aggregates and dates

**DATE_TRUNC** — snap a timestamp to a grain (day, week, month, …).

```sql
SELECT time, DATE_TRUNC('day', time) AS day, place, mag
FROM earthquake.data2020;
```

**DATE_PART / EXTRACT** — pull one field (the year/month drop away).

```sql
SELECT time, DATE_PART('day', time) AS day, place, mag
FROM earthquake.data2020;

SELECT time, EXTRACT(DAY FROM time) AS day, place, mag
FROM earthquake.data2020;
```

**HAVING** — filter *after* GROUP BY. WHERE cannot see `SUM(...)`.

```sql
SELECT team, SUM(wins) AS n_wins
FROM nba.team_stats
GROUP BY team
HAVING SUM(wins) > 500
ORDER BY n_wins DESC;
```

**DISTINCT** — one row per unique value.

```sql
SELECT DISTINCT department FROM moma.artworks;
```

**ROUND** — nearest integer, or a set number of decimals.

```sql
SELECT team, ROUND(AVG(wins)) AS avg_wins
FROM nba.team_stats
GROUP BY team
ORDER BY avg_wins DESC;
```

## SkillBuilder 5 — Joining

**INNER JOIN** — only matching keys.

```sql
SELECT a.title, b.name
FROM chinook.album AS a
INNER JOIN chinook.artist AS b
    ON a.artist_id = b.artist_id;
```

**LEFT JOIN** — keep every left-table row; unmatched right side is NULL.

```sql
SELECT a.customername, b.ordernumber
FROM initech.customers AS a
LEFT JOIN initech.orders AS b
    ON a.customernumber = b.customernumber;
```

**FULL OUTER JOIN** — keep unmatched rows from both sides.

```sql
SELECT
    a.album_id,
    a.title AS album_title,
    b.name AS track_title
FROM chinook.album AS a
FULL OUTER JOIN chinook.track AS b
    ON a.album_id = b.album_id;
```

**UNION** — stack compatible SELECTs; drops duplicate rows.

```sql
SELECT time, mag, place FROM earthquake.data2015
UNION
SELECT time, mag, place FROM earthquake.data2016;
```

## SkillBuilder 6 — Cleaning

**||** — concatenate strings.

```sql
SELECT
    appt_start_date,
    firstname || ' ' || lastname AS full_name
FROM wh_visits.data2016a;
```

**UPPER / LOWER**

```sql
SELECT DISTINCT
    UPPER(firstname) || ' ' || UPPER(lastname) AS full_name
FROM wh_visits.data2016a;
```

**CASE WHEN** — a new column from conditions.

```sql
SELECT
    *,
    CASE
        WHEN product ILIKE '%road%' THEN 'Road'
        WHEN product ILIKE '%mountain%' THEN 'Mountain'
        WHEN product ILIKE '%touring%' THEN 'Touring'
    END AS bike_type
FROM sales_data.bikes
WHERE product_category = 'Bikes';
```

(The course example omitted the `%` wildcards around `road` /
`mountain` / `touring`. With ILIKE those literals only match a
description that *is* the word. The portfolio Instacart query uses
`BETWEEN` on extracted hours instead.)
