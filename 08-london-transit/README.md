# Why do people ride the Underground, and from which zone?

Transport for London asked for a weekday picture of the Tube: volume,
peak times, why people travel, and how that mix changes as you leave
central London. The table is `tfl.rods` — 6,295 rows from the Rolling
Origin and Destination Survey, modelled as a typical November weekday.

The queries in [`queries/`](queries/) are the ones I wrote. The totals
below are what I recorded from the course SQL app.

## Each row is a profile, not a trip

`COUNT(*)` would count travel profiles and understate Zone 1.
`SUM(daily_journeys)` is the volume.

```sql
SELECT SUM(daily_journeys) AS total_journeys
FROM tfl.rods;
```

[`01_total_journeys.sql`](queries/01_total_journeys.sql)

**4,878,330** journeys on a typical day. **51.7%** of them start in
Zone 1. The busiest period is **PM peak**.

[`02_by_entry_zone.sql`](queries/02_by_entry_zone.sql) ·
[`03_by_time_period.sql`](queries/03_by_time_period.sql)

## Finding — "Home" as an origin is not the commute

Grouped by origin purpose, **Home** has the most journeys — the
system looks like a home-commute network. Grouped by
**origin × destination** purpose, the picture changes:

[`04_by_origin_purpose.sql`](queries/04_by_origin_purpose.sql) ·
[`05_origin_destination_pairs.sql`](queries/05_origin_destination_pairs.sql)

**Home → Work** is the most-used pair. Some people are finding other
ways home from work, so the return leg does not mirror the morning
exactly. A single-column `GROUP BY` would have stopped at "people
leave home."

## Finding — Zone 1 is the job hub; Zones 2–5 are where people live

People leave **Home** in the morning through midday, and the peak
from **Work** is PM peak — the clock behaves as expected.

[`06_purpose_by_time.sql`](queries/06_purpose_by_time.sql) ·
[`07_purpose_by_zone.sql`](queries/07_purpose_by_zone.sql)

The mix is geographic. **Work** origins dominate **Zone 1**. **Home**
ranks higher in **Zones 2–5**. Zone 1 is the business centre; the
outer rings are home, education, and shops.

Tourist travel does not use the commute clock. Tourism-related trips
sit in the **midday** peak and often start from Home, while work peaks
in the morning and evening.

[`08_tourism_by_time.sql`](queries/08_tourism_by_time.sql)

## Recommendation

1. **Add peak-time capacity into Zone 1**, and **boost service out of
   Zone 1 in the evening** — that is the job-hub pattern in the data.
2. Do not staff or schedule the whole network as if every zone were
   Zone 1. Outer zones are feeding the centre in the morning and
   receiving people at night.
3. Treat tourism as a **midday** demand stream, not a second commute.

## Limitations

- RODS is a model of a typical November weekday, not a specific day
  I could audit.
- Zone 1's 51.7% share was divided outside SQL, as the assignment
  required.
- I do not have cost, crowding, or delay columns, so the
  recommendation is about where demand sits, not about a timetable.

## How I used AI on this project

I wrote the `GROUP BY` queries and recorded 4,878,330 journeys / 51.7%
Zone 1 myself. The original lab asked ChatGPT what Zone 1-as-work vs
Zones 2–5-as-home means for planners; the peak-capacity recommendation
is the one I wrote after that. Cursor packaged the Google Doc into this
folder without changing those details.

## Skills demonstrated

`SUM` vs `COUNT(*)` on the right grain · `GROUP BY` one column, then
two · sorting aggregated results · `WHERE` on a slice before
aggregating · reading a pair (Home → Work) instead of a single label
· turning a zone mix into an operations recommendation

## Data

GCA Querying Data track, Transport for London RODS extract. Table:
`tfl.rods`. The course SQL app is not public, so this folder ships
the queries and the result totals I recorded rather than a copy of
the table.
