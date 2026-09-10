# SQL

SQL is not a charting tool, so this section is built the way I would want a
hiring manager to read it: one **end-to-end analysis** that uses SQL to answer
a business question, and a **query log** of the patterns behind it.

That split follows [Matt Mike's guidance on adding SQL to a data
portfolio](https://thdatapoint.substack.com/p/how-to-add-sql-to-your-data-portfolio):
a step-by-step analysis with the queries and the findings in one place, plus a
GitHub query log of example problems and syntax. I do not have a Tableau or
Power BI dashboard from this coursework — the execution environment was the
course SQL app — so the visuals in the Intel project are charts of the result
totals I recorded from those queries.

## Featured analysis

**[Intel device-repurposing strategy](../05-intel-device-repurposing/)** —
which devices should Intel collect next if the goal is energy and CO₂, not
headcount? `LEFT JOIN`, age buckets, CTEs, and grouped summaries, ending in a
recommendation.

## Query log

**[sql/query-log/](query-log/)** — eight files, each one pattern and one
question from the SQL track (YouTube trending, Crunchbase, London Underground,
NBA, FastKitchen, Instacart, Intel, Too Sweet bakery).
