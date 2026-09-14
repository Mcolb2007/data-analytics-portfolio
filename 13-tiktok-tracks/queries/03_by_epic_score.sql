-- Which track has the highest Epic Records velocity score?
-- IS NOT NULL so missing scores do not sort as the top of the list.

SELECT *
FROM tiktok.tracks
WHERE epic_score IS NOT NULL
ORDER BY epic_score DESC;
