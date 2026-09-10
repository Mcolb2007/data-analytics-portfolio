-- SELECT, ORDER BY, LIMIT
-- Problem: Which YouTube trending videos had the most comments?
-- Dataset: youtube.trending (Milestone 1)
-- Why this pattern: ORDER BY ranks the table; LIMIT keeps the ranking
-- readable. OFFSET 99 LIMIT 1 is how I pulled the 100th-ranked video
-- without dumping 100 rows and reading the last one.

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
