-- How many cleantech companies put solar, power, or energy in the name?
-- Parentheses around the ILIKE list keep OR from leaking past the
-- category_code filter. Without them, any company named "%energy%"
-- would match even if it was not cleantech.

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
