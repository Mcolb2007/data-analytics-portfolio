-- How many comments does the 100th-ranked video have?
-- OFFSET 99 LIMIT 1 skips the top 99 and returns only rank 100.
-- Changing LIMIT to 100 and reading the last row would work, but
-- it is the wrong habit once the table is large.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY comment_count DESC
OFFSET 99
LIMIT 1;
