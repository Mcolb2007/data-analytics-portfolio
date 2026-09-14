# Which not-yet-#1 TikTok tracks look signable?

Epic Records wanted tracks that are already moving on TikTok but are
not finished hits — names a scouting team can still get to. The table
is `tiktok.tracks`: title, artist, posts, days on chart, peak rank,
explicit flag, genre, and `epic_score` (0–1, Epic's internal chart
velocity).

The queries in [`queries/`](queries/) are the ones I wrote. Counts
and names below are what I recorded from the course SQL app.

## Posts, velocity, and peak rank do not pick the same song

[`01_all_tracks.sql`](queries/01_all_tracks.sql) — **7,024** tracks.

| Ranking | Track I recorded | Posts |
|---|---|---|
| Most posts | **Beat Automotivo Tan Tan Tan Viral** | **36,500,000** |
| Highest `epic_score` | **APT** (ROSÉ and Bruno Mars) | **4,500,000** |
| Peak rank 1, fewest posts | **GO GO** (BTS) | **450,200** |

[`02_by_posts.sql`](queries/02_by_posts.sql) ·
[`03_by_epic_score.sql`](queries/03_by_epic_score.sql) ·
[`04_peak_rank_tiebreak.sql`](queries/04_peak_rank_tiebreak.sql)

GO GO peaked at **#1 with about 1.0% of the posts** of the most-posted
track. Volume is not the same thing as chart position. APT's post
count is an order of magnitude below the volume leader even though
it leads on velocity. I dropped NULL `epic_score` and NULL
`peak_rank` so missing values could not win those rankings.

## Finding — filter for "moving" without "already won"

```sql
SELECT *
FROM tiktok.tracks
WHERE num_posts BETWEEN 6000000 AND 10000000
  AND peak_rank <> 1
ORDER BY num_posts DESC;
```

[`05_six_to_ten_million.sql`](queries/05_six_to_ten_million.sql) ·
[`06_not_yet_number_one.sql`](queries/06_not_yet_number_one.sql)

6–10 million posts returns **81** tracks. Dropping peak rank 1 leaves
**60**. That band is high enough to be real and low enough that the
#1 slot is still open.

The five names I sent to scouting, using top-10 placement, an
`epic_score` above 0.3, repeat appearances, and time on chart above
365 days (not a one-week spike):

**JVKE · PURI · Tommy Richman · The Kid LAROI · Pinkfong**

They blew up fast, placed more than once in the top 10, and stayed on
the chart long enough that people kept listening.

## Recommendation

1. **Do not sign off volume alone.** The post leader and the #1 with
   450k posts are different products.
2. **Scout the 6–10M band that has not peaked at 1.** That is 60
   tracks in this extract, not 7,024.
3. Require **repeat top-10 placement, epic_score > 0.3, and >365 days
   on chart** so a one-week meme does not look like a catalog.

## Limitations

- TikTok chart extract from the GCA SQL app, not Epic's production
  scouting database.
- The genre LevelUp queries in the original lab were not filled in,
  so this write-up does not invent a genre ranking.
- Artist selection is a scored filter plus judgement, not a model.

## How I used AI on this project

I wrote the ranking and scouting-band queries myself and recorded
7,024 tracks, 36.5M / 4.5M / 450,200 posts, and the 81 → 60 row
filters. The original lab included a ChatGPT prompt about the
volume-leader track; I left that answer blank in the Doc, so it is
not filled in here. Cursor packaged the Google Doc into this folder
without changing those details.

## Skills demonstrated

`ORDER BY` on competing metrics · `IS NOT NULL` so missing scores do
not rank first · tie-break with a second `ORDER BY` · `BETWEEN` ·
compound `WHERE` (`AND`, `<>`) · defining a scouting band instead of
taking the top of one list

## Data

GCA Querying Data track, LiveLab. Table: `tiktok.tracks`. The course
SQL app is not public, so this folder ships the queries and the
result totals I recorded rather than a copy of the table.
