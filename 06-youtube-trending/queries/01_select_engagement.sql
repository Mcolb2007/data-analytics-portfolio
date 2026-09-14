-- Which columns actually measure engagement on a trending video?
-- SELECT is not "get everything" — it is choosing the grain a manager
-- can read: title, channel, views, likes, dislikes, comments.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending;
