-- Which genres appear most often on the TikTok chart?
-- SkillBuilder 3: COUNT + GROUP BY. Milestone LiveLab LevelUp box
-- was empty; this is that unused block.

SELECT
    genre,
    COUNT(*) AS n_tracks
FROM tiktok.tracks
GROUP BY genre
ORDER BY n_tracks DESC;
