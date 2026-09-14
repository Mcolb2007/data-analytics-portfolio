# SQL

SQL is not a charting tool, so this section is built the way I would want a
hiring manager to read it: **end-to-end analyses** that use SQL to answer a
business question, and a **query log** of the patterns behind them.

That split follows [Matt Mike's guidance on adding SQL to a data
portfolio](https://thdatapoint.substack.com/p/how-to-add-sql-to-your-data-portfolio):
a step-by-step analysis with the queries and the findings in one place, plus a
GitHub query log of example problems and syntax. I do not have a Tableau or
Power BI dashboard from this coursework — the software I used to write and run
the queries was **SQL Pad** — so each write-up uses the result totals I recorded
from those queries. The Intel capstone also has charts of those totals.

Every analysis below is from my original GCA Google Docs. The queries, recorded
numbers, and conclusions are unchanged. The GitHub folders highlight the skill
each one actually used.

## Analyses

| # | Project | Question | Skill the analysis hangs on |
|---|---|---|---|
| [05](../05-intel-device-repurposing/) | **Intel device-repurposing strategy** (capstone) | Which devices should Intel collect next if the goal is energy and CO₂, not headcount? | `LEFT JOIN`, age buckets, CTEs, grouped summaries |
| [06](../06-youtube-trending/) | **YouTube trending engagement** | What separates a top-commented video from the 1,000th? | `ORDER BY`, `LIMIT` / `OFFSET` |
| [07](../07-crunchbase-investments/) | **Crunchbase startup investments** | Are highly funded closed companies a cleantech warning? | `WHERE`, `IS NULL`, `ILIKE` |
| [08](../08-london-transit/) | **London Underground ridership** | Why do people ride, and from which zone? | `GROUP BY`, `SUM` vs `COUNT(*)` |
| [09](../09-nba-performance/) | **NBA home-court and three-point shooting** | Does a hot three-point rate win home games? | `HAVING` vs `WHERE` |
| [10](../10-fastkitchen-customers/) | **FastKitchen guest vs registered spend** | How do you profile a customer base that includes guests? | `LEFT JOIN` on `NULL` user_id |
| [11](../11-too-sweet-bakery/) | **Too Sweet bakery waste** | Which products convert production into sales instead of waste? | `SUM(x) / SUM(y)` inside the aggregate |
| [12](../12-instacart-take-home/) | **Instacart support staffing** | When should support be staffed if night is the peak? | `EXTRACT` + `CASE WHEN` |
| [13](../13-tiktok-tracks/) | **TikTok track scouting** | Which not-yet-#1 tracks look signable? | `BETWEEN` and compound filters |
| [14](../14-terracotta-survey/) | **Terracotta online-store pivot** | What should an online plant shop stock and explain? | Join + `WITH` CTE, `HAVING` |

## Query log

**[sql/query-log/](query-log/)** — eight files, each one pattern and one
question from the SQL track. The full write-up for each of those questions is
in the project folders above.

## SkillBuilders (relearning)

**[sql/skillbuilders/](skillbuilders/)** — the course syntax recap plus the
SkillBuilder practice worksheets with the empty query boxes filled in. Open
a `.sql` file, hide the answer, write your own, then run it in SQL Pad.
