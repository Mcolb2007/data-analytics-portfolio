# What should an online plant shop stock — and explain?

Eben is taking Terracotta from a brick-and-mortar shop to online-only.
He surveyed former, current, and prospective customers about what they
buy and why, then asked for a data-backed stocking and marketing
read. Two tables: `terracotta.survey` and `terracotta.plant_info`
(light, water, maintenance, toxicity).

The queries in [`queries/`](queries/) are the ones I wrote. Counts
and percentages below are what I recorded from the course SQL app.

## Join the plant to the survey, then freeze that grain

The analysis grain is **a survey response with the plant's care
attributes attached**. I joined on `plant_types = plant`, then locked
it in a `WITH` CTE so later counts could not drift off that join.

```sql
WITH survey_full AS (
    SELECT
        s.*,
        p.*
    FROM terracotta.survey AS s
    LEFT JOIN terracotta.plant_info AS p
        ON s.plant_types = p.plant
)
SELECT
    COUNT(*) AS num_responses,
    maintenance_requirements
FROM survey_full
GROUP BY maintenance_requirements
ORDER BY num_responses DESC;
```

[`03_join_survey_plants.sql`](queries/03_join_survey_plants.sql) ·
[`04_survey_full_cte.sql`](queries/04_survey_full_cte.sql) ·
[`05_by_maintenance.sql`](queries/05_by_maintenance.sql)

**217** responses in the joined table.

## Finding — people already buy easy and safe

| | Result I recorded |
|---|---|
| Low-maintenance as the plant they buy most | **79%** of responses |
| Safe for pets and children | **99%** of responses |
| Reason categories with at least 30 responses | **3** |

[`06_by_toxicity.sql`](queries/06_by_toxicity.sql) ·
[`07_reasons.sql`](queries/07_reasons.sql) ·
[`08_reasons_having_30.sql`](queries/08_reasons_having_30.sql)

The online catalog should not lead with rare, high-maintenance, or
toxic plants. Almost every respondent is already buying something
safe for a house with pets or kids, and four-fifths want low
maintenance. `HAVING COUNT(*) >= 30` is how I stopped treating a
reason with a handful of mentions as if it were a market.

The original lab also asked for the share of responses that listed
care requirements, and the share that listed pet-safety, as the
*reason* for purchase. Those boxes were empty.
[`12_reason_share.sql`](queries/12_reason_share.sql) fills them with
SkillBuilder 3 `COUNT` and SkillBuilder 4 `ROUND` against the 217
denominator I did record. Read the two percentages off the output;
they are not invented here.

## LevelUp — frequency and free text

Empty boxes in the original Doc, filled from SkillBuilders 2 and 3:

[`09_by_frequency.sql`](queries/09_by_frequency.sql) — `GROUP BY freq`.
[`10_frequency_by_reason.sql`](queries/10_frequency_by_reason.sql) —
weekly vs once-a-year buyers, same reasons table.
[`11_pet_safe_free_text.sql`](queries/11_pet_safe_free_text.sql) —
`ILIKE` for pet / dog / cat / toddler / child / toxic / safe, compared
to the coded `reason_for_purchase` column. One substring (`pet-friendly`)
would miss "I love my cat too much," which is the point of the drill.

## Recommendation

Lead the online store with **low-maintenance, pet- and child-safe
plants**, and put **care information** (light, watering, pet-safe)
next to the product instead of behind a blog post. That is what 79%
and 99% of this survey already do in the physical shop. High-care or
toxic SKUs are a niche, not the homepage.

(The original lab's longer marketing-prompt box was left blank. The
recommendation above is only the stocking implication of the counts
I did record.)

## Limitations

- 217 survey responses, not a customer census.
- `reason_for_purchase` is a category a senior analyst assigned from
  free text; query 11 is a SkillBuilder 2 recode of the free-response
  column so I can compare the two.
- Frequency × reason and the reason-share query were empty in the
  original Doc; they are filled here from SkillBuilders 2–4 without
  inventing the resulting counts.

## How I used AI on this project

I wrote the join, CTE, and `HAVING` queries myself and recorded 217
responses, 79% low-maintenance, 99% pet-safe, and 3 reason categories
at 30+ responses. The original lab's longer ChatGPT marketing prompt
was left blank; this README does not invent that answer. Cursor
packaged the Google Doc into this folder without changing those details.

## Skills demonstrated

`LEFT JOIN` on a coded plant type · `WITH` CTE to freeze the join ·
`GROUP BY` maintenance, toxicity, and purchase frequency · `HAVING`
on a grouped count · `ILIKE` recode of free text · converting survey
shares into a catalog decision

## Data

GCA Querying Data track, LiveLab. Tables: `terracotta.survey`,
`terracotta.plant_info`. The course SQL app is not public, so this
folder ships the queries and the result totals I recorded rather
than a copy of the warehouse.
