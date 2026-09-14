# What separates a top-commented YouTube video from the 1,000th?

A digital media consultancy asked for an initial read of **6,351 US
trending videos** (`youtube.trending`, November 2017–June 2018): how
views, likes, and comments relate to a video's chance of trending, and
what a client should actually optimize for.

The work was done in SQL Pad.
The queries in [`queries/`](queries/) are the ones I wrote. Rankings
below are the result totals I recorded from those queries.

## Ranking is a choice, not a default

The first useful query is not `SELECT *`. It is choosing the columns a
manager can act on — title, channel, views, likes, dislikes, comments —
then deciding **which of those is the ranking**.

[`01_select_engagement.sql`](queries/01_select_engagement.sql)

Ordered by likes, the top video is **BTS (방탄소년단) 'FAKE LOVE' Official
MV**. Ordered by comments, the top video is **So Sorry.** Likes and
comments do not tell the same story. The most-disliked ranking was an
empty box in the original Doc; [`07_most_disliked.sql`](queries/07_most_disliked.sql)
fills it with the SkillBuilder 1 `ORDER BY … DESC` pattern. I never
recorded the video name, so it is not invented here.

```sql
SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY comment_count DESC
LIMIT 10;
```

[`03_most_commented.sql`](queries/03_most_commented.sql) ·
[`04_top_10_comments.sql`](queries/04_top_10_comments.sql)

## Finding — comments fall off fast, then flatten

I used `OFFSET` to pull a single rank instead of dumping a hundred rows
and reading the last one.

| Rank by comments | Comments I recorded |
|---|---|
| 10th | **371,864** |
| 100th | **53,665** |
| 1,000th | **7,155** |

The 10th-most-commented video has **0.27×** the comments of the #1
video. The drop from 10 → 100 is steeper than the drop from 100 →
1,000. The top of the chart is a different object from the middle.

[`05_100th_commented.sql`](queries/05_100th_commented.sql) ·
[`06_1000th_commented.sql`](queries/06_1000th_commented.sql)

## Finding — the kind of video changes as you leave the top

At the top 10, titles look controversial or already-popular, and the
same YouTube-native creators keep showing up — the comment counts are
high enough that people are reacting, not just watching. Around rank
100 there are more YouTube creators mixed in and view counts are still
high. By rank 1,000 the list is mostly **music videos and celebrity or
company channels**, with comments in the low thousands: not much needs
to be said about those videos.

Likes do not follow the same shape. They jump and drop more sharply
than comments, they decline faster among lower-ranked videos, and the
most-liked videos are not always the most-commented. Many of the
high-like, high-view titles were trending music videos. The unused
LevelUp code for that check is
[`08_likes_long_tail.sql`](queries/08_likes_long_tail.sql) — the same
`OFFSET 9 / 99 / 999` ranks as comments, ordered by likes.

## Recommendation

If the client wants **reach**, optimize for the like/view pattern:
music and already-famous names. If the client wants **conversation**,
optimize for the comment pattern: titles and creators that invite a
reaction. Treating "trending" as one metric would mix those two jobs.

## Limitations

- This is a US trending snapshot from Nov 2017–June 2018, not a
  current chart.
- The most-disliked query and the likes long-tail queries were empty
  in the original Doc; they are filled here from SkillBuilder 1
  (`ORDER BY`, `OFFSET`) without inventing result names.
- Ratio of 10th-to-1st comments (0.27) was calculated outside SQL, as
  the assignment required.

## How I used AI on this project

I wrote the ranking queries and recorded the comment counts myself in
SQL Pad. The original lab included a ChatGPT prompt about why a
heavily disliked video might also draw comments; the interpretation of
the 10 / 100 / 1,000 drop-off is mine. Cursor packaged the Google Doc
into this folder without changing those details.

## Skills demonstrated

`SELECT` of an analysis grain · `ORDER BY` as a ranking choice ·
`LIMIT` · `OFFSET` to pull a specific rank · the same long-tail check
on likes · comparing two metrics that do not rank the same way

## Data

GCA Querying Data track. Table: `youtube.trending`. SQL Pad is not a
public tool, so this folder ships the queries and the result totals
I recorded rather than a copy of the table.
