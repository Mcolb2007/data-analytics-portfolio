-- How many comments does the 1,000th-ranked video have?
-- OFFSET is zero-based: the 1,000th row is OFFSET 999 LIMIT 1.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY comment_count DESC
OFFSET 999
LIMIT 1;
