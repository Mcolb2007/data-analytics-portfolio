-- Of the companies that closed, which twelve had raised the most?
-- Adding status = 'closed' is the same ranking with a different
-- population. That is how a "top funded" list becomes a failure list.

SELECT
    name,
    category_code,
    status,
    funding_total_usd
FROM crunchbase.companies
WHERE funding_total_usd IS NOT NULL
  AND category_code IS NOT NULL
  AND status = 'closed'
ORDER BY funding_total_usd DESC
LIMIT 12;
