-- Viral-but-not-saturated: 6M–10M posts.
-- 81 rows if the bounds are right.

SELECT *
FROM tiktok.tracks
WHERE num_posts BETWEEN 6000000 AND 10000000
ORDER BY num_posts DESC;
