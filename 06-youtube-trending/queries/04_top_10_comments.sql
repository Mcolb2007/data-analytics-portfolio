-- What does the top of the comment ranking look like?
-- LIMIT 10 keeps the ranking readable instead of dumping 6,351 rows.

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
