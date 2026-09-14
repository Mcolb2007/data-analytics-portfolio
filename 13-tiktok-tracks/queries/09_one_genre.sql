-- Restrict to one genre after reading 07 / 08.
-- SkillBuilder 2 WHERE. Substitute the genre name the previous
-- query actually returned — do not hard-code a guess.

SELECT *
FROM tiktok.tracks
WHERE genre = 'pop'   -- replace with the genre from 07 or 08
ORDER BY num_posts DESC;
