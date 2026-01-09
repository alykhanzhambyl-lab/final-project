-- SELECT TOP 5 * FROM dbo.bronze_ecb_fx_usd_eur_v2 ORDER BY [TIME_PERIOD] DESC;
-- This commented query retrieves the latest 5 records from the table 
-- ordered by the TIME_PERIOD column in descending order to see recent data.

-- SELECT COUNT(*) cnt, MIN([TIME_PERIOD]) min_d, MAX([TIME_PERIOD]) max_d FROM dbo.bronze_ecb_fx_usd_eur_v2;
-- This commented query counts total rows and finds the earliest and latest TIME_PERIOD values.

-- Main query to get summary statistics of the data in dbo.bronze_ecb_fx_usd_eur_v2 table:
SELECT 
  -- Total number of records in the table
  COUNT(*) AS cnt,
  -- The earliest date/time value in the TIME_PERIOD column
  MIN([TIME_PERIOD]) AS min_d,
  -- The latest date/time value in the TIME_PERIOD column
  MAX([TIME_PERIOD]) AS max_d
FROM 
  dbo.bronze_ecb_fx_usd_eur_v2;
 