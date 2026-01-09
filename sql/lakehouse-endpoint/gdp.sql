-- SELECT TOP 5 *
-- FROM dbo.bronze_worldbank_gdp_v2
-- ORDER BY [date] DESC;
-- The above commented query would retrieve the 5 most recent records
-- from the bronze_worldbank_gdp_v2 table based on the date column

SELECT 
  -- Count the total number of rows in the table
  COUNT(*) AS cnt,
  -- Find the earliest date in the date column
  MIN([date]) AS min_year,
  -- Find the latest date in the date column
  MAX([date]) AS max_year
FROM dbo.bronze_worldbank_gdp_v2;
-- This query provides summary statistics about the date range and total records
-- in the bronze_worldbank_gdp_v2 table
 