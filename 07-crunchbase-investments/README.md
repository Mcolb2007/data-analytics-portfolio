# Are the most-funded closed startups a warning about cleantech?

A venture firm wanted a first pass on Crunchbase company data
(`crunchbase.companies`, 20 columns, 27,000+ rows): who raised the
most, who raised a lot and still closed, and whether one industry is
over-represented in that second list.

The queries in [`queries/`](queries/) are the ones I wrote in the
course SQL app. The totals below are what I recorded from them.

## NULL funding is not zero funding

Ranking on `funding_total_usd` without handling NULL would let unknown
amounts sort as if they belonged at the top. I filtered them out, and
filtered missing industries the same way, before taking the top twelve.

```sql
SELECT
    name,
    category_code,
    status,
    funding_total_usd
FROM crunchbase.companies
WHERE funding_total_usd IS NOT NULL
  AND category_code IS NOT NULL
ORDER BY funding_total_usd DESC
LIMIT 12;
```

[`01_top_funded.sql`](queries/01_top_funded.sql)

**Clearwire** is the most-funded company in this extract. Of those
twelve, **1** is listed as acquired rather than operating or IPO.
Clearwire received **5.7% more** funding than the 12th-most-funded
company on that list.

None of the top twelve are `closed`. That is the next question.

## Finding — the closed list is a cleantech list

[`02_top_closed.sql`](queries/02_top_closed.sql)

The highest-funded closed company is **Abound Solar**, at
**$510,000,000**. **6 of the 12** most-funded closed companies are
`cleantech`.

That is a different fact from "cleantech companies fail more often."
The next two queries separate those.

| | Result I recorded |
|---|---|
| Cleantech companies in the table | **898** |
| Closed rate in the full table | **7.9%** |
| Closed rate among cleantech | **7.0%** |
| Cleantech names containing solar, power, or energy | **275** |

[`03_all_cleantech.sql`](queries/03_all_cleantech.sql) ·
[`04_closed_cleantech.sql`](queries/04_closed_cleantech.sql) ·
[`05_cleantech_name_search.sql`](queries/05_cleantech_name_search.sql)

Cleantech is **over-represented among well-funded failures** and
**not** over-represented among closures overall. The industry is not
failing more; the expensive bets in it are the ones that show up when
you rank on money.

The name search is the LevelUp on `ILIKE` and parentheses: 275 of 898
cleantech companies advertise solar, power, or energy in the name.
Without the parentheses, `OR` would have ignored the category filter.

## Recommendation

Treat cleantech as **high-risk, high-reward**, not as a bad sector.
The closed rate is slightly *below* the table average. The warning is
about **patience and complexity**: these companies take longer to show
a return, the path to profit is less traditional, and investors who
expect a normal software timeline will call a long-cycle company a
failure. Underwrite the time-to-payoff, not just the category.

## Limitations

- Crunchbase status (`operating` / `ipo` / `acquired` / `closed`) is
  a snapshot, not a survival curve.
- The 5.7% gap between #1 and #12 on the funded list, and the 7.0%
  closed rate, were calculated outside SQL from the recorded row
  counts, as the assignment required.
- "6 of 12 closed companies are cleantech" is a reading of the top of
  a ranked list, not a statistical test.

## How I used AI on this project

I wrote the `WHERE` / `ILIKE` queries and recorded the row counts myself.
The original lab asked ChatGPT whether cleantech is a bad investment; I
kept my own read (high-risk, high-reward, longer time-to-payoff). Cursor
packaged the Google Doc into this folder without changing those details.

## Skills demonstrated

`WHERE` · `IS NOT NULL` so missing values do not rank as winners ·
`ILIKE` with wildcards · parentheses so `AND`/`OR` mean what they look
like · ranking a subset (`status = 'closed'`) · separating "common in
the expensive-failure list" from "fails more often"

## Data

GCA Querying Data track. Table: `crunchbase.companies`. The course SQL
app is not public, so this folder ships the queries and the result
totals I recorded rather than a copy of the table.
