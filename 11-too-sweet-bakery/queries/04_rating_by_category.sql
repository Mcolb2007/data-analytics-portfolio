-- Which category do customers rate highest?
SELECT
    product_category,
    AVG(avg_rating) AS mean_avg
FROM too_sweet.data
GROUP BY product_category
ORDER BY mean_avg DESC;
