# SQL SkillBuilders — syntax and relearning drills

This folder is the **practice track**, not the portfolio analyses.

The GCA SkillBuilder Google Docs were mostly blank copies (`Paste your
query here`). I filled those unused blocks here using the course
[SkillBuilder Summary](https://docs.google.com/document/d/1-AVfaOpDX298p3hihikl7K5NjavOhnDsvJtSz-yzYrU)
examples, so I can reopen a drill without hunting Drive. Run any query
in the [GCA SQL app](https://sql.hq.globaltech.org/queries/new).

| File | What it is | Original Doc |
|---|---|---|
| [syntax.md](syntax.md) | Recap of all six SkillBuilders with the course examples | [SkillBuilder Summary](https://docs.google.com/document/d/1-AVfaOpDX298p3hihikl7K5NjavOhnDsvJtSz-yzYrU) |
| [practice/01-querying.sql](practice/01-querying.sql) | SELECT, FROM, ORDER BY, LIMIT, OFFSET | [SB1 Practice](https://docs.google.com/document/d/1CBfEHR3GIiZwnaFlw2BfWo849LL_Ry1wX8cZwRwwVrQ) |
| [practice/02-filtering.sql](practice/02-filtering.sql) | WHERE, BETWEEN, IN, LIKE/ILIKE, NULL, AND/OR/NOT | [SB2 Practice](https://docs.google.com/document/d/1iNVkKQqVyexJl0eB-40Y1O5XR4oBcyTHKEUL0OS2nPg) |
| [practice/03-aggregations.sql](practice/03-aggregations.sql) | COUNT, SUM, MIN/MAX, AVG, GROUP BY, aliases | [SB3 Practice](https://docs.google.com/document/d/1QqUoolccaO2ZbKNAmnBX3Mn9YyJJpmYCiKJjQ0lL-8w) |
| [practice/04-dates-having.sql](practice/04-dates-having.sql) | DATE_PART, EXTRACT, GROUP BY on time | [SB4 Practice](https://docs.google.com/document/d/1tDg95kgSYh5EgRDAvEAt4EMdJ-iLmGZDsOB7kV7CJio) · [official solutions](https://docs.google.com/document/d/1rsW7ZzuQ7SJwRgXhBFxCjb5VPuy9gXqtBWE5_HONPtM) |
| [practice/05-joins.sql](practice/05-joins.sql) | INNER / LEFT / FULL OUTER JOIN, UNION | Summary examples (no SB5 practice Doc in Drive) |
| [practice/06-cleaning.sql](practice/06-cleaning.sql) | `\|\|`, UPPER/LOWER, CASE WHEN | Summary examples (no SB6 practice Doc in Drive) |

## How to relearn

1. Open the `.sql` file for the skill that is rusty.
2. Read the prompt in the comment, hide the query, write your own.
3. Compare, then run it in the SQL app.
4. Jump to the **portfolio project** that uses the same pattern for
   real:

| SkillBuilder | Portfolio project that uses it |
|---|---|
| 1 SELECT / ORDER BY / LIMIT / OFFSET | [06 YouTube](../../06-youtube-trending/) |
| 2 WHERE / ILIKE / IS NULL | [07 Crunchbase](../../07-crunchbase-investments/), [13 TikTok](../../13-tiktok-tracks/) |
| 3 GROUP BY / aggregations | [08 London](../../08-london-transit/), [11 Too Sweet](../../11-too-sweet-bakery/) |
| 4 DATE_PART / HAVING / ROUND | [09 NBA](../../09-nba-performance/), [12 Instacart](../../12-instacart-take-home/) |
| 5 JOIN | [10 FastKitchen](../../10-fastkitchen-customers/), [05 Intel](../../05-intel-device-repurposing/), [14 Terracotta](../../14-terracotta-survey/) |
| 6 CASE WHEN | [12 Instacart](../../12-instacart-take-home/), [05 Intel](../../05-intel-device-repurposing/) |

## What is filled vs recorded

- **Queries** in this folder fill the empty SkillBuilder boxes. Column
  names follow the prompts; if the SQL app errors, preview the table
  and adjust.
- **Result numbers** are only included where the course published
  them (SkillBuilder 4 official solutions). Everything else says
  "read from the SQL app" — I am not inventing row counts I never
  recorded.
