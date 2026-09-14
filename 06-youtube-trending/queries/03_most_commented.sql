-- Which trending video had the most comments?
-- Likes and comments do not rank the same videos. Ranking on
-- comment_count is how I found the engagement story, not the
-- popularity story.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY comment_count DESC;
