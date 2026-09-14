-- Which twelve companies received the most funding?
-- IS NOT NULL on funding_total_usd stops unknown funding from sorting
-- as if it were the top of the list. The same filter on category_code
-- drops rows that have money but no industry to interpret.

SELECT
    name,
    category_code,
    status,
    funding_total_usd
FROM crunchbase.companies
WHERE funding_total_usd IS NOT NULL
  AND category_code IS NOT NULL
ORDER BY funding_total_usd DESC
LIMIT 12;
