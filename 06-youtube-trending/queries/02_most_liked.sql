-- Which trending video had the most likes?
-- ORDER BY likes DESC ranks the table; the first row is the answer.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY likes DESC;
