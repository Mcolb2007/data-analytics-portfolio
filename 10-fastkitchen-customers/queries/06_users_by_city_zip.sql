-- Is "Allen has the most users" a city story or a zip story?
-- Adding zip shows whether one city is winning because it contains
-- more zip codes.

SELECT
    city,
    zip,
    COUNT(user_id) AS number_of_users
FROM fastkitchen.users
GROUP BY city, zip
ORDER BY number_of_users DESC;
