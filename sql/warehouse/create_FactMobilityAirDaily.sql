IF OBJECT_ID('dbo.FactMobilityAirDaily_v2', 'U') IS NOT NULL
  DROP TABLE dbo.FactMobilityAirDaily_v2;
SELECT t.date_key,t.trips_cnt,t.revenue_total,t.avg_total_amount,t.avg_fare_amount,t.avg_trip_distance,t.usd_eur_rate,t.revenue_eur,t.gdp_usd,
       a.pm25_avg_value,a.no2_avg_value,a.pm25_obs_cnt,a.no2_obs_cnt
INTO dbo.FactMobilityAirDaily_v2
FROM dbo.FactTaxiDaily_v2 AS t
JOIN (
    SELECT date_key,
         AVG(CASE WHEN parameter_name='pm25' THEN avg_value END) pm25_avg_value, AVG(CASE WHEN parameter_name='no2' THEN avg_value END) no2_avg_value,
         SUM(CASE WHEN parameter_name='pm25' THEN obs_cnt ELSE 0 END) pm25_obs_cnt, SUM(CASE WHEN parameter_name='no2' THEN obs_cnt ELSE 0 END) no2_obs_cnt
    FROM dbo.FactAirQualityDaily_v2
    WHERE parameter_name IN ('pm25','no2')
    GROUP BY date_key
) AS a ON a.date_key = t.date_key;

SELECT COUNT(*) AS cnt FROM dbo.FactMobilityAirDaily_v2;
SELECT TOP (10) *
FROM dbo.FactMobilityAirDaily_v2
ORDER BY date_key;

