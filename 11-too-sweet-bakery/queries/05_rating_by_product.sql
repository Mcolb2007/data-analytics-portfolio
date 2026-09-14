-- Drill from category into product: rating and comment volume.
SELECT
    product_category,
    product,
    AVG(avg_rating) AS mean_avg,
    SUM(comment_count) AS total_comments
FROM too_sweet.data
GROUP BY product_category, product
ORDER BY mean_avg DESC;
