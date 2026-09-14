# What separates a top-commented YouTube video from the 1,000th?

A digital media consultancy asked for an initial read of **6,351 US
trending videos** (`youtube.trending`, November 2017–June 2018): how
views, likes, and comments relate to a video's chance of trending, and
what a client should actually optimize for.

The work was done in SQL in the Global Career Accelerator's query app.
The queries in [`queries/`](queries/) are the ones I wrote. Rankings
below are the result totals I recorded from those queries.

## Ranking is a choice, not a default

The first useful query is not `SELECT *`. It is choosing the columns a
manager can act on — title, channel, views, likes, dislikes, comments —
then deciding **which of those is the ranking**.

[`01_select_engagement.sql`](queries/01_select_engagement.sql)

Ordered by likes, the top video is **BTS (방탄소년단) 'FAKE LOVE' Official
MV**. Ordered by comments, the top video is **So Sorry.** Likes and
comments do not tell the same story.

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
high-like, high-view titles were trending music videos.

## Recommendation

If the client wants **reach**, optimize for the like/view pattern:
music and already-famous names. If the client wants **conversation**,
optimize for the comment pattern: titles and creators that invite a
reaction. Treating "trending" as one metric would mix those two jobs.

## Limitations

- This is a US trending snapshot from Nov 2017–June 2018, not a
  current chart.
- I did not fill the most-disliked query in the original lab, so this
  write-up does not invent a dislike ranking.
- Ratio of 10th-to-1st comments (0.27) was calculated outside SQL, as
  the assignment required.

## How I used AI on this project

I wrote the ranking queries and recorded the comment counts myself in the
course SQL app. The original lab included a ChatGPT prompt about why a
heavily disliked video might also draw comments; the interpretation of
the 10 / 100 / 1,000 drop-off is mine. Cursor packaged the Google Doc
into this folder without changing those details.

## Skills demonstrated

`SELECT` of an analysis grain · `ORDER BY` as a ranking choice ·
`LIMIT` · `OFFSET` to pull a specific rank · comparing two metrics
that do not rank the same way · reading a long tail instead of only
the top row

## Data

GCA Querying Data track. Table: `youtube.trending`. The course SQL app
is not public, so this folder ships the queries and the result totals
I recorded rather than a copy of the table.
