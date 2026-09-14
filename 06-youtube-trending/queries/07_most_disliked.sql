-- Which trending video had the most dislikes?
-- SkillBuilder 1: ORDER BY DESC. The original Milestone 1 box for
-- this query was left blank; this is that unused block filled with
-- the same ranking pattern as likes and comments.
-- I did not record the video name, so the README does not invent it.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY dislikes DESC;
