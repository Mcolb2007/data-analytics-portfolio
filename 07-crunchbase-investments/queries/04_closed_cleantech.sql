-- What share of cleantech companies closed?
-- Same filter as 03, plus status. Compare the row count to 03 and
-- to the 7.9% closed rate for the full table.

SELECT
    name,
    category_code,
    status
FROM crunchbase.companies
WHERE category_code = 'cleantech'
  AND status = 'closed';
