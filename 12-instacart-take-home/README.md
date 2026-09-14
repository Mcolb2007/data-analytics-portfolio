# When should Instacart staff support if night is the peak?

This was a take-home in the shape of a real Instacart data-analyst
interview: look at `instacart.data` (orders, location, ratings,
reported issues) and answer two open questions — what do you notice
about the business, and how would you staff Customer Support?

The queries in [`queries/`](queries/) are the ones I wrote in the
course SQL app. The staffing call below is the finding I recorded:
**Night has the most orders.**

## Timestamps are too sharp to staff against

`order_date` is a timestamp. Support does not hire by the minute.
`EXTRACT(HOUR FROM order_date)` pulls the hour; `CASE WHEN` turns 24
hours into four windows a manager can put people in.

```sql
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM order_date) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    COUNT(order_id) AS total_orders
FROM instacart.data
GROUP BY time_of_day
ORDER BY total_orders DESC;
```

[`03_time_buckets.sql`](queries/03_time_buckets.sql) ·
[`04_orders_by_window.sql`](queries/04_orders_by_window.sql)

**Night is the largest bucket.** A 9-to-5 support roster is staffed
against the wrong peak.

## Finding — volume of issues and damage to the rating are different lists

The next questions I asked of the same table:

- Are there low-rated orders with **no** issue reported?
- Which issues are reported most often?
- Do those issues spike at a specific time?

[`05_issue_frequency.sql`](queries/05_issue_frequency.sql) ranks issue
types by how often they appear. [`06_issues_by_rating.sql`](queries/06_issues_by_rating.sql)
ranks the same types by **average customer rating**, lowest first.

Staffing against the most common issue alone would miss the issue
that hurts the score. I did not record the issue-type names and
counts from the SQL app into the original lab write-up, so they are
not invented here — the queries are the work product.

## Recommendation

1. **Staff Customer Support onto the night window**, not a daytime
   default. Night has the most orders in this extract.
2. Build the roster from **two rankings**: issue frequency *and*
   rating damage. They will not be the same list.
3. Follow up on low ratings with no issue reported — those are
   customers who were unhappy and never opened a case.

## Limitations

- This is a GCA upload of an interview-style take-home, not
  Instacart production data.
- I recorded the time-of-day winner (Night) but not the order counts
  per window or the issue-type frequencies, so those numbers are
  omitted rather than estimated.
- The original lab's presentation box was left blank; this README is
  the document version of the completed queries and the Night finding.

## How I used AI on this project

I wrote the `EXTRACT` / `CASE WHEN` buckets and the issue-type queries
myself, and recorded that Night has the most orders. The original lab
suggested ChatGPT for brainstorming business questions; the three I
kept are low ratings with no issue, most frequent issues, and whether
issues spike at a time of day. Cursor packaged the Google Doc into this
folder without changing those details.

## Skills demonstrated

`EXTRACT` on a timestamp · `CASE WHEN` to turn hours into staffable
windows · `GROUP BY` a derived label · filtering `issue_reported = 1`
· ranking the same dimension two ways (count vs average rating) ·
asking the next business question instead of stopping at a correct
query

## Data

GCA Querying Data track, LiveLab take-home. Table: `instacart.data`.
The course SQL app is not public, so this folder ships the queries
and the finding I recorded rather than a copy of the table.
