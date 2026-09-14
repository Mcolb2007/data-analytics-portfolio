-- Drop tracks that already peaked at #1.
-- 60 rows after the extra filter. These are the names a scouting
-- team can still get to.

SELECT *
FROM tiktok.tracks
WHERE num_posts BETWEEN 6000000 AND 10000000
  AND peak_rank <> 1
ORDER BY num_posts DESC;
