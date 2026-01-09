IF OBJECT_ID('dbo.FactEconomyTaxiDaily_v2', 'U') IS NOT NULL
  DROP TABLE dbo.FactEconomyTaxiDaily_v2;

SELECT date_key,trips_cnt,revenue_total,revenue_eur,usd_eur_rate,gdp_usd,
  revenue_total / NULLIF(CAST(trips_cnt AS float), 0) AS avg_rev_per_trip_usd,
  revenue_eur   / NULLIF(CAST(trips_cnt AS float), 0) AS avg_rev_per_trip_eur
INTO dbo.FactEconomyTaxiDaily_v2
FROM dbo.FactMobilityAirDaily_fxfilled_v2;

-- корреляция: avg_rev_per_trip_usd --- usd_eur_rate
WITH d AS (
  SELECT
    CAST(avg_rev_per_trip_usd AS float) AS x,
    CAST(usd_eur_rate AS float) AS y
  FROM dbo.FactEconomyTaxiDaily_v2
  WHERE avg_rev_per_trip_usd IS NOT NULL AND usd_eur_rate IS NOT NULL
)
SELECT 
  COUNT(*) AS n,(COUNT(*) * SUM(x*y) - SUM(x)*SUM(y)) /
  NULLIF(SQRT( (COUNT(*)*SUM(x*x) - SUM(x)*SUM(x)) * (COUNT(*)*SUM(y*y) - SUM(y)*SUM(y)) ),0) AS corr_avg_usd_per_trip__fx
FROM d;

WITH d AS (
  SELECT
    CAST(avg_rev_per_trip_eur AS float) AS x,
    CAST(usd_eur_rate AS float) AS y
  FROM dbo.FactEconomyTaxiDaily_v2
  WHERE avg_rev_per_trip_eur IS NOT NULL AND usd_eur_rate IS NOT NULL
)
SELECT
  COUNT(*) AS n,(COUNT(*) * SUM(x*y) - SUM(x)*SUM(y)) /
  NULLIF(SQRT( (COUNT(*)*SUM(x*x) - SUM(x)*SUM(x)) * (COUNT(*)*SUM(y*y) - SUM(y)*SUM(y)) ),0) AS corr_avg_eur_per_trip__fx
FROM d;

SELECT TOP (12) date_key,trips_cnt,usd_eur_rate,avg_rev_per_trip_usd,avg_rev_per_trip_eur,gdp_usd
FROM dbo.FactEconomyTaxiDaily_v2
ORDER BY date_key;