-- Which genres have the highest average post count?
-- SkillBuilder 3: AVG + GROUP BY. Frequency (07) and average posts
-- will not necessarily pick the same genre.

SELECT
    genre,
    COUNT(*) AS n_tracks,
    AVG(num_posts) AS avg_posts
FROM tiktok.tracks
GROUP BY genre
ORDER BY avg_posts DESC;
