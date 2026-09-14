-- Where do registered users live?
SELECT
    city,
    COUNT(user_id) AS number_of_users
FROM fastkitchen.users
GROUP BY city
ORDER BY number_of_users DESC;
