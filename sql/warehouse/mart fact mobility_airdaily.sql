IF OBJECT_ID('dbo.DimFX_filled_v2', 'U') IS NOT NULL
  DROP TABLE dbo.DimFX_filled_v2;

SELECT dd.date_key,dd.[date],fx_fill.usd_eur_rate AS usd_eur_rate_filled
INTO dbo.DimFX_filled_v2
FROM dbo.DimDate_v2 dd
OUTER APPLY (
  SELECT TOP (1) fx2.usd_eur_rate
  FROM dbo.DimFX_v2 fx2
  WHERE fx2.date_key <= dd.date_key
    AND fx2.usd_eur_rate IS NOT NULL
  ORDER BY fx2.date_key DESC
) fx_fill;

IF OBJECT_ID('dbo.FactMobilityAirDaily_fxfilled_v2', 'U') IS NOT NULL
  DROP TABLE dbo.FactMobilityAirDaily_fxfilled_v2;

SELECT f.date_key, f.trips_cnt,f.revenue_total,f.avg_total_amount,f.avg_fare_amount,f.avg_trip_distance,fx.usd_eur_rate_filled AS usd_eur_rate,
  f.revenue_total / NULLIF(fx.usd_eur_rate_filled, 0) AS revenue_eur,f.gdp_usd,f.pm25_avg_value,f.no2_avg_value,f.pm25_obs_cnt,f.no2_obs_cnt

INTO dbo.FactMobilityAirDaily_fxfilled_v2
FROM dbo.FactMobilityAirDaily_v2 f
JOIN dbo.DimFX_filled_v2 fx
  ON fx.date_key = f.date_key;





SELECT COUNT(*) AS cnt
FROM dbo.FactMobilityAirDaily_fxfilled_v2;

SELECT COUNT(*) AS null_fx_days
FROM dbo.FactMobilityAirDaily_fxfilled_v2
WHERE usd_eur_rate IS NULL OR revenue_eur IS NULL;

SELECT TOP (12)
  date_key, usd_eur_rate, revenue_total, revenue_eur
FROM dbo.FactMobilityAirDaily_fxfilled_v2
ORDER BY date_key;

-- FX на 20190101 ближайшим следующим значением
UPDATE fx
SET usd_eur_rate_filled = next_fx.usd_eur_rate
FROM dbo.DimFX_filled_v2 fx
CROSS APPLY (
  SELECT TOP (1) fx2.usd_eur_rate
  FROM dbo.DimFX_v2 fx2
  WHERE fx2.date_key >= fx.date_key
    AND fx2.usd_eur_rate IS NOT NULL
  ORDER BY fx2.date_key ASC
) next_fx
WHERE fx.date_key = 20190101
  AND fx.usd_eur_rate_filled IS NULL;

IF OBJECT_ID('dbo.FactMobilityAirDaily_fxfilled_v2', 'U') IS NOT NULL
  DROP TABLE dbo.FactMobilityAirDaily_fxfilled_v2;

SELECT f.date_key,f.trips_cnt,f.revenue_total,f.avg_total_amount,f.avg_fare_amount,f.avg_trip_distance,
  fx.usd_eur_rate_filled AS usd_eur_rate,f.revenue_total / NULLIF(fx.usd_eur_rate_filled, 0) AS revenue_eur,f.gdp_usd,f.pm25_avg_value,f.no2_avg_value,
  f.pm25_obs_cnt,f.no2_obs_cnt
INTO dbo.FactMobilityAirDaily_fxfilled_v2
FROM dbo.FactMobilityAirDaily_v2 f
JOIN dbo.DimFX_filled_v2 fx
  ON fx.date_key = f.date_key;

SELECT COUNT(*) AS cnt,
  SUM(CASE WHEN usd_eur_rate IS NULL OR revenue_eur IS NULL THEN 1 ELSE 0 END) AS null_days
FROM dbo.FactMobilityAirDaily_fxfilled_v2;

SELECT TOP (3) date_key, usd_eur_rate, revenue_total, revenue_eur
FROM dbo.FactMobilityAirDaily_fxfilled_v2
ORDER BY date_key;