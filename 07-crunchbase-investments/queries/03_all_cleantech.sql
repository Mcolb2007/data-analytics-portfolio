-- How large is the cleantech category in this table?
-- Row count from the SQL app information bar is the denominator
-- for the closed-rate comparison in 04.

SELECT
    name,
    category_code,
    status
FROM crunchbase.companies
WHERE category_code = 'cleantech';
