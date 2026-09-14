-- Same long-tail check as comments, ranked by likes.
-- SkillBuilder 1 OFFSET: 10th, 100th, 1,000th. The Milestone 1
-- LevelUp asked whether likes follow the comment-count shape.
-- I wrote the interpretation in the Doc; these queries were the
-- unused code.

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY likes DESC
OFFSET 9
LIMIT 1;

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY likes DESC
OFFSET 99
LIMIT 1;

SELECT
    title,
    channel_title,
    views,
    likes,
    dislikes,
    comment_count
FROM youtube.trending
ORDER BY likes DESC
OFFSET 999
LIMIT 1;
