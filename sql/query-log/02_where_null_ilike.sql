-- WHERE, IS NULL, ILIKE
-- Problem: Which highly funded startups closed, and how many of the
-- closed cleantech companies have solar / power / energy in the name?
-- Dataset: crunchbase.companies (Milestone 2)
-- Why this pattern: IS NOT NULL stops unknown funding from sorting as
-- if it were zero. Parentheses around the ILIKE list keep OR from
-- leaking past the cleantech filter.

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

SELECT
    name,
    category_code,
    status
FROM crunchbase.companies
WHERE category_code = 'cleantech'
  AND (
        name ILIKE '%solar%'
        OR name ILIKE '%power%'
        OR name ILIKE '%energy%'
      );
