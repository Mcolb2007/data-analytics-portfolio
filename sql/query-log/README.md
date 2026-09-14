# SQL query log

A working library of SQL I actually used in the Global Career Accelerator, not
a syntax cheat sheet copied from a tutorial.

Each file is one **pattern**, one **business question**, and the query I wrote
to answer it. I keep it this way so I can look up "how did I filter after a
`GROUP BY`?" and land on a problem I have already defended, not a generic
`SELECT`.

The full write-ups that use these patterns are the SQL projects
**[05](../../05-intel-device-repurposing/)–[14](../../14-terracotta-survey/)**.
Intel is the capstone that combines several of them.

| File | Pattern | Question I was answering | Full write-up |
|---|---|---|---|
| [01_select_order_by_limit.sql](01_select_order_by_limit.sql) | `SELECT`, `ORDER BY`, `LIMIT` | Which trending videos drew the most comments? | [06](../../06-youtube-trending/) |
| [02_where_null_ilike.sql](02_where_null_ilike.sql) | `WHERE`, `IS NULL`, `ILIKE` | Which well-funded startups closed — and how many closed cleantech names mention solar, power, or energy? | [07](../../07-crunchbase-investments/) |
| [03_group_by_aggregations.sql](03_group_by_aggregations.sql) | `GROUP BY`, `SUM` | Why do people ride the Underground, and from which zone? | [08](../../08-london-transit/) |
| [04_having.sql](04_having.sql) | `HAVING` vs `WHERE` | How many hot three-point teams still lost at home? | [09](../../09-nba-performance/) |
| [05_left_join.sql](05_left_join.sql) | `LEFT JOIN` | What is average order value by zip when guests have no account? | [10](../../10-fastkitchen-customers/) |
| [06_case_when_extract.sql](06_case_when_extract.sql) | `CASE WHEN`, `EXTRACT` | When should Instacart staff support if night is the peak? | [12](../../12-instacart-take-home/) |
| [07_cte_with.sql](07_cte_with.sql) | `WITH` CTEs | What share of each region's carbon savings comes from laptops? | [05](../../05-intel-device-repurposing/) |
| [08_ratio_inside_aggregation.sql](08_ratio_inside_aggregation.sql) | `SUM(x) / SUM(y)` | Which bakery products convert production into sales instead of waste? | [11](../../11-too-sweet-bakery/) |

