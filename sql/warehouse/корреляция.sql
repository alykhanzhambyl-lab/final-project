-- корреляция trips_cnt ↔ pm25_avg_value
WITH d AS (
  SELECT CAST(trips_cnt AS float) AS x, CAST(pm25_avg_value AS float) AS y
  FROM dbo.FactMobilityAirDaily_v2
  WHERE pm25_avg_value IS NOT NULL
)
SELECT COUNT(*) AS n, (COUNT(*) * SUM(x*y) - SUM(x)*SUM(y)) / NULLIF(SQRT((COUNT(*)*SUM(x*x) - SUM(x)*SUM(x)) * (COUNT(*)*SUM(y*y) - SUM(y)*SUM(y))),0) AS corr_trips_pm25
FROM d;

-- корреляция trips_cnt ↔ no2_avg_value
WITH d AS (
  SELECT CAST(trips_cnt AS float) AS x, CAST(no2_avg_value AS float) AS y
  FROM dbo.FactMobilityAirDaily_v2
  WHERE no2_avg_value IS NOT NULL
)
SELECT
  COUNT(*) AS n,
  (COUNT(*) * SUM(x*y) - SUM(x)*SUM(y)) / NULLIF(SQRT((COUNT(*)*SUM(x*x) - SUM(x)*SUM(x)) * (COUNT(*)*SUM(y*y) - SUM(y)*SUM(y))),0) AS corr_trips_no2
FROM d;
-- топ “пиков” по PM2.5
SELECT TOP (10) date_key, trips_cnt, pm25_avg_value, no2_avg_value
FROM dbo.FactMobilityAirDaily_v2
ORDER BY pm25_avg_value DESC;
-- топ “пиков” по NO2
SELECT TOP (10) date_key, trips_cnt, pm25_avg_value, no2_avg_value
FROM dbo.FactMobilityAirDaily_v2
ORDER BY no2_avg_value DESC;
-- топ дней по количеству поездок (trips)
SELECT TOP (10) date_key, trips_cnt, pm25_avg_value, no2_avg_value
FROM dbo.FactMobilityAirDaily_v2
ORDER BY trips_cnt DESC;
