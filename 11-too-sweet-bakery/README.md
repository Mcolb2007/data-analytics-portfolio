# Which bakery products convert production into sales instead of waste?

Too Sweet wants to bake what customers love and throw less of it away.
Three months of production data live in `too_sweet.data`: category,
product, ratings, comments, quantity produced / sold / wasted.

The queries in [`queries/`](queries/) are the ones I wrote. The
percentages and product names below are what I recorded from the
course SQL app.

## Waste is a ratio, not a leftover count

The starter query grouped by date but selected `product AS count` —
it never summed production. The fix is `SUM(quantity_produced)`.
Waste as a share of what was baked is the metric that survives
different bake volumes:

```sql
100 * (SUM(quantity_wasted) / SUM(quantity_produced)) AS waste_pct
```

[`01_produced_by_day.sql`](queries/01_produced_by_day.sql) ·
[`03_daily_waste_pct.sql`](queries/03_daily_waste_pct.sql)

Daily waste runs **3% to 13%**. Something is leftover **every day**.

## Finding — the highest-rated category is also the waste problem

| | Result I recorded |
|---|---|
| Highest-rated category | **Handmade Pastries & Scones** (4.6) |
| Lowest-rated category | **Cookies, Brownies & Bars** (3.9) |
| Most-loved products | **Croissants** and **Savory Croissants** (4.8) |
| Most waste by category | Handmade pastries and scones |
| Least waste by category | Cookies, brownies and bars |
| Most waste by product | **Pastry Special** |

[`04_rating_by_category.sql`](queries/04_rating_by_category.sql) ·
[`05_rating_by_product.sql`](queries/05_rating_by_product.sql) ·
[`06_waste_by_category.sql`](queries/06_waste_by_category.sql) ·
[`07_waste_by_product.sql`](queries/07_waste_by_product.sql)

Love and leftover move together here. Baking more of what people
rate highly, without a sales-efficiency check, is how you grow waste
in the popular case.

## Finding — croissants sell through; the pastry special does not

Sales efficiency is `SUM(sold) / SUM(produced)`. `NULLIF` on the
denominator guards a zero-bake product.

[`08_sales_efficiency.sql`](queries/08_sales_efficiency.sql) ·
[`09_efficiency_and_waste.sql`](queries/09_efficiency_and_waste.sql)

**Croissants** had the highest efficiency — they sell out and are not
wasted as much. **Pastry Special** had the lowest: over-produced
relative to what sells, and the waste leader.

## Recommendation

1. **Cut production of the high-waste pastries** — specifically
   Pastry Special — by about half the waste percentage, then watch
   whether the rate comes down before cutting further.
2. **Bake more of what runs out**, starting with croissants.
3. Next data to collect: **price**, the **text of comments** on the
   most-wasted products, and a sold-and-rating view so "best" is not
   only a star average. Cost of the pastry special is the first
   question I would add, because price may be why it sits.

## Limitations

- Three months of bakery production, not a year, so seasonality is
  not in the file.
- Ratings are already stored as `avg_rating`; I averaged those, which
  is the grain the table gives, not a re-weighted mean from raw
  reviews.
- No cost, time-of-day, or weather columns.

## How I used AI on this project

I wrote the production, rating, waste, and sales-efficiency queries
myself, including the debug of the starter query that never summed
production. The original lab allowed ChatGPT as a teammate for further
questions; the three follow-ups (price of the pastry special, comment
text, reuse of wasted product) are the ones I listed. Cursor packaged
the Google Doc into this folder without changing those details.

## Skills demonstrated

Debugging a grouped query that never aggregated · ratio inside
`GROUP BY` (`SUM(x) / SUM(y)`) · `ROUND` · `NULLIF` on a divisor ·
drilling from category to product · pairing a satisfaction metric
with an operations metric so "most loved" is not automatically
"bake more"

## Data

GCA Querying Data track, LiveLab. Table: `too_sweet.data`. The course
SQL app is not public, so this folder ships the queries and the
result totals I recorded rather than a copy of the table.
