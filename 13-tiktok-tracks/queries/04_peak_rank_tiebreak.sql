-- What is the lowest post count among tracks that still peaked at #1?
-- Secondary ORDER BY num_posts ASC breaks ties on peak_rank.

SELECT *
FROM tiktok.tracks
WHERE peak_rank IS NOT NULL
  AND num_posts IS NOT NULL
ORDER BY peak_rank ASC, num_posts ASC;
