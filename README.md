# Data Analytics Portfolio — Maurice Colbert Jr.

Four Python analyses and one SQL analysis built from my coursework in the **Global
Career Accelerator**. Each one starts from a business or research question, documents
the reasoning behind every analytical decision, and ends in a recommendation with its
limitations stated.

**Bowling Green State University** · B.S. Software Engineering, Minor in Information
Systems · Honors Program
[LinkedIn](https://www.linkedin.com/in/maurice-c-64b14a301) · mauricc@bgsu.edu

<p>
  <img src="assets/badges/python-and-data-grammys.png" width="115" alt="Python & Data certification, with The Recording Academy">
  <img src="assets/badges/querying-data-sql-intel.png" width="115" alt="Querying Data (SQL) certification, with Intel">
  <img src="assets/badges/ai-professional-skills-openai.png" width="115" alt="AI Professional Skills certification, with OpenAI">
  <img src="assets/badges/intercultural-skills-unesco.png" width="115" alt="Intercultural Skills certification, with UNESCO">
</p>

Four certifications completed March–May 2026: **Python & Data** (with The Recording
Academy), **Querying Data / SQL** (with Intel), **AI Professional Skills** (with OpenAI),
and **Intercultural Skills** (with UNESCO).

→ **[Certifications, curriculum, and learning outcomes](LEARNING-OUTCOMES.md)**

---

## Projects

| # | Project | Question | Core skills |
|---|---|---|---|
| [01](01-grammys-website-analytics/) | **Grammys website split analysis** | Did splitting grammy.com from recordingacademy.com improve engagement? | pandas, ratio metrics, seasonality controls, hypothesis testing, stakeholder reporting |
| [02](02-olympic-medalists/) | **120 years of Olympic medalists** | What story is hiding in 39,783 medal records? | Exploratory analysis, missing-data auditing, data journalism |
| [03](03-mars-weather/) | **Identifying a planet from its weather** | Which planet produced this rover telemetry? | Data forensics, orbital-cycle detection, multi-signal verification |
| [04](04-dc-national-parks/) | **DC National Parks campaign targeting** | Where and when should the Park Service promote? | Concentration analysis, seasonality, data-quality triage |
| [05](05-intel-device-repurposing/) | **Intel device-repurposing strategy** | Which devices should Intel collect next to maximize energy and CO₂ savings? | SQL joins, CTEs, `CASE` buckets, grouped summaries, recommendation |

Python notebooks are committed **with outputs and charts already rendered**. The SQL
project is a step-by-step query story with the result charts built from totals I
recorded in the course SQL app, plus a [query log](sql/query-log/) of the patterns
behind it.

---

## Headline findings

**01 — Grammys website split.** Awards nights draw 43x the traffic of a regular day, and
awards week accounts for 40–65% of annual traffic every year. Because of that spike, I
built the analysis on volume-independent ratio metrics and controlled for seasonality by
comparing matching February–May windows. The split improved the fan site (bounce rate
42.3% → 38.8%, pages per session 1.97 → 2.20), and the Academy site is the stickiest
property at 128.5 seconds per session against the fan site's 83.0. I also **disproved the
stated hypothesis**: the two audiences differ by at most 2.0 percentage points in any age
bracket, so age cannot explain the engagement gap — intent does. The most actionable
finding was one the original brief never asked about: the Academy site's bounce rate rises
to 45.1% during awards season, meaning show-night overflow lands on pages not built for it.

**02 — Olympic medalists.** The age range of medalists is 63 years wide (10 to 73), and
chasing that outlier revealed that five of the ten oldest medalists in history won in
**Art Competitions** — a real Olympic programme that awarded 156 medals between 1912 and
1948 before being abolished. Three independent signals confirm the same underlying shift:
art medals stop after 1948, women rise from 0% to 47.9% of medalists, and events per
Games grow from 43 to 306. Auditing missingness by era (75% of pre-1936 records have no
height) is what stopped me from publishing an invalid "athletes are getting bigger"
comparison.

**03 — Mars weather.** Working from telemetry with the planet's identity withheld, I
measured the local day at 1.027 Earth days, then detected solar-longitude wraps to measure
two complete orbits at 668 and 669 local days — **687 Earth days, an exact match for
Mars**, with no other planet within 400 days. Temperature and pressure behaviour
independently confirm it: −68 °C to −83 °C average lows, a 63.6 °C mean daily swing, and a
23% annual pressure cycle caused by CO₂ polar caps freezing out of the atmosphere.

**04 — DC National Parks.** Visits are extremely concentrated (Lincoln Memorial alone is
20.5% of 41.3M visits; the top five sites are 64.2%) and strongly seasonal (3.6x
peak-to-trough, 79.9% of visits between March and October), while non-recreation traffic
is almost perfectly flat — so only one of the two demand streams is worth advertising
against. I also flagged rather than reported a site logging 30 visits for the entire year,
because that is a broken counter, not a finding.

**05 — Intel device repurposing.** 601,740 devices saved 6,768 tons of CO₂, but volume
and per-device savings move in opposite directions: 7+ year machines save 48 kWh each
while newer ones dominate intake. I recommended collecting **4–6 year corporate
laptops** (already 67% of volume, 32 kWh and 0.0140 tons each, 264k devices) and routing
them toward higher-carbon grids — Asia avoids 0.0155 tons per device against North
America's 0.0103.

---

## What this portfolio demonstrates

A full breakdown of the program's modules and the outcomes I can point to evidence for is
in **[LEARNING-OUTCOMES.md](LEARNING-OUTCOMES.md)**. In brief:

**Python for data analysis** — pandas for cleaning, reshaping, grouping, joining, and
aggregating; matplotlib for charts built to be read rather than decorated.

**SQL** — joins, derived columns, `CASE WHEN` buckets, `WITH` CTEs, `GROUP BY` /
`HAVING`, and ratio-inside-aggregation, shown in
[project 05](05-intel-device-repurposing/) and the [SQL query log](sql/query-log/).

**Analytical judgement** — choosing metrics that survive the shape of the data, testing a
stated hypothesis instead of confirming it, controlling for seasonality, and separating a
data-quality problem from a finding.

**Communication** — every project states its question, its reasoning, its recommendation,
and its limitations, with a stakeholder-ready summary. My
[intercultural communication work](communication/) is included separately.

**Working with AI** — documented, evaluated, and corrected rather than pasted. See below.

---

## How AI was used in this portfolio

I want to be straightforward about this, because the course included an AI Professional
Skills certification and being able to say precisely where a tool helped is part of the
skill.

**The analysis is mine.** I completed all of the original coursework myself: writing the
pandas code, choosing the metrics, running the queries, interpreting the results, and
writing the conclusions and recommendations. Every finding in this repository came out of
my own work with the data.

**AI was a copilot, not the analyst.** During the coursework I used ChatGPT the way I
would use documentation or a teammate — syntax lookups (f-string number formatting,
converting month numbers to names, grouped-bar-chart parameters), a second opinion on how
to handle missing values, and a first draft of one stakeholder memo. In each case I
verified the output against the data. In the Grammys project the AI-drafted memo confidently
repeated a premise from my own prompt — that the two audiences differ by age — which my
demographic analysis had already disproved, so I rewrote it. Each Python project notebook
and the Intel SQL write-up ends with a **"How I used AI on this project"** section
recording exactly what I asked for and what I changed.

**AI helped me publish this repository.** After the course I used an AI coding assistant
(Cursor) to repackage the coursework for GitHub: restructuring the notebooks so the
reasoning behind each step is explicit rather than reading as answers to assignment
prompts, replacing course-provided task instructions with my own framing, rebuilding the
charts, writing this documentation, and setting up the repository. The SQL section is the same:
the queries and findings are from my GCA Google Docs; the GitHub layout follows a
step-by-step analysis plus a query log. The analytical substance is unchanged from my
own work — the packaging and presentation were done with AI assistance.

Nothing here is a copied solution. If it matters to you which parts are which, the
per-project AI notes are specific.

---

## Running the projects

```bash
git clone https://github.com/Mcolb2007/data-analytics-portfolio.git
cd data-analytics-portfolio

python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt

jupyter lab                      # open any project notebook
```

Rebuild every notebook from source and re-execute it:

```bash
./tools/build.sh                 # all projects
./tools/build.sh 03-mars-weather # one project
```

Notebooks are authored as [jupytext](https://jupytext.readthedocs.io/) `_src.py` files and
compiled to `.ipynb`, which keeps the version history readable — a code review shows the
actual change instead of a wall of JSON.

## Repository layout

```
├── 01-grammys-website-analytics/   Website split analysis (Recording Academy)
├── 02-olympic-medalists/           Exploratory analysis + data journalism pitch
├── 03-mars-weather/                Identifying a planet from telemetry
├── 04-dc-national-parks/           Campaign targeting and seasonality
├── 05-intel-device-repurposing/    SQL analysis: which devices to collect next
├── sql/query-log/                  SQL patterns from original GCA coursework
├── communication/                  Intercultural communication coursework
├── assets/badges/                  Certification badges
├── LEARNING-OUTCOMES.md            Curriculum and learning outcomes
├── tools/build.sh                  Rebuild and execute all notebooks
└── requirements.txt
```

Python project folders contain a `README.md`, the executed notebook, its jupytext
`_src.py` source, `data/`, and `figures/`. The SQL project contains the queries, a
write-up of the findings, and charts of the recorded result totals.

---

## Data sources

Python project datasets were provided as part of the Global Career Accelerator
curriculum and are included here so the analyses reproduce. They originate from The
Recording Academy (website and social analytics), a public Olympic medal history
dataset (1896–2016), NASA's Curiosity rover REMS weather record, and the National Park
Service visitation statistics.

The SQL project uses a GCA warehouse designed to reflect Intel's device-repurposing
program. The course SQL app is not public, so that folder ships the queries I wrote
and the result totals I recorded, not a copy of the tables.

## License

[MIT](LICENSE) for the code and analysis. The datasets remain the property of their
original sources and are included for educational reproducibility.
