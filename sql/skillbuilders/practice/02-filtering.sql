-- SkillBuilder 2 Practice — WHERE, BETWEEN, IN, LIKE/ILIKE, NULL, AND/OR/NOT
-- Original Doc: https://docs.google.com/document/d/1iNVkKQqVyexJl0eB-40Y1O5XR4oBcyTHKEUL0OS2nPg
-- Empty boxes filled. Row counts: read from SQL Pad.

-- =============================================================================
-- WHERE  |  sales_data.cars  (~2,500 California listings)
-- =============================================================================

-- 1. Highway mpg of 25 or less. How many?
SELECT *
FROM sales_data.cars
WHERE highway_mpg <= 25;

-- 2. Oldest car among those.
SELECT *
FROM sales_data.cars
WHERE highway_mpg <= 25
ORDER BY year ASC;

-- 3. Ford make, model, year, city and highway mpg. How many Fords?
SELECT make, model, year, city_mpg, highway_mpg
FROM sales_data.cars
WHERE make = 'Ford';

-- 4. Ford with the highest city mpg.
SELECT make, model, year, city_mpg, highway_mpg
FROM sales_data.cars
WHERE make = 'Ford'
ORDER BY city_mpg DESC;


-- =============================================================================
-- BETWEEN and IN  |  iowa.ames_housing
-- Keep the SELECT list tight: saleprice, lot_area, neighborhood,
-- bldg_type, house_style.
-- =============================================================================

-- 1. Highest sale price, and which neighborhood.
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
ORDER BY saleprice DESC;

-- 2. How many sold between $200,000 and $400,000?
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE saleprice BETWEEN 200000 AND 400000;

-- 3. Largest lot for a townhouse (Twnhs or TwnhsE).
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE bldg_type IN ('Twnhs', 'TwnhsE')
ORDER BY lot_area DESC;


-- =============================================================================
-- LIKE and ILIKE  |  yelp.business
-- =============================================================================

-- 1. How many restaurants in a city named "Saint Joseph"?
SELECT *
FROM yelp.business
WHERE city = 'Saint Joseph';

-- 2. City starts with "Saint".
SELECT *
FROM yelp.business
WHERE city LIKE 'Saint%';

-- 3. City is "Gilbert" or "GILBERT" — ILIKE ignores case.
SELECT *
FROM yelp.business
WHERE city ILIKE 'gilbert';

-- 4. Categories mention African anywhere in the string.
SELECT *
FROM yelp.business
WHERE categories ILIKE '%African%';


-- =============================================================================
-- IS NULL  |  imdb.data
-- =============================================================================

-- 1. Movies missing duration.
SELECT *
FROM imdb.data
WHERE duration IS NULL;

-- 2. Of those, highest IMDB rating.
SELECT *
FROM imdb.data
WHERE duration IS NULL
ORDER BY imdb_score DESC;

-- 3. Is missing budget more common than missing gross?
SELECT COUNT(*) AS missing_budget
FROM imdb.data
WHERE budget IS NULL;

SELECT COUNT(*) AS missing_gross
FROM imdb.data
WHERE gross IS NULL;


-- =============================================================================
-- AND, OR, NOT  |  iowa.ames_housing
-- =============================================================================

-- 1. Sale price over $300k OR lot > 15,000 sq ft.
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE saleprice > 300000
   OR lot_area > 15000;

-- 2. Single-family (1Fam) with lot < 10,000.
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE bldg_type = '1Fam'
  AND lot_area < 10000;

-- 3. Lowest sale price among those.
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE bldg_type = '1Fam'
  AND lot_area < 10000
ORDER BY saleprice ASC;

-- 4. Smallest lot that is NOT a townhouse.
SELECT saleprice, lot_area, neighborhood, bldg_type, house_style
FROM iowa.ames_housing
WHERE bldg_type NOT IN ('Twnhs', 'TwnhsE')
ORDER BY lot_area ASC;


-- =============================================================================
-- Combining AND, OR, NOT  |  yelp.business
-- Parentheses keep OR from leaking past AND. This is the same trap
-- as the Crunchbase ILIKE list in project 07.
-- =============================================================================

-- 1. Names ending in possessive 's  (double the apostrophe in SQL).
SELECT *
FROM yelp.business
WHERE name ILIKE '%''s';

-- 2. Those that do NOT list Fast Food in categories.
SELECT *
FROM yelp.business
WHERE name ILIKE '%''s'
  AND categories NOT ILIKE '%Fast Food%';

-- 3. Nevada businesses tagged Burgers OR Pizza.
--    Parentheses required so NV applies to both tags.
SELECT *
FROM yelp.business
WHERE state = 'NV'
  AND (
        categories ILIKE '%Burgers%'
        OR categories ILIKE '%Pizza%'
      );

-- 4. Of those, not in Henderson / Las Vegas / North Las Vegas —
--    including leftover city names that contain 'Vegas'.
--    The Doc warns: NOT IN those three cities still leaves 'Vegas'
--    variants. Filter the substring too.
SELECT *
FROM yelp.business
WHERE state = 'NV'
  AND (
        categories ILIKE '%Burgers%'
        OR categories ILIKE '%Pizza%'
      )
  AND city NOT IN ('Henderson', 'Las Vegas', 'North Las Vegas')
  AND city NOT ILIKE '%Vegas%';
