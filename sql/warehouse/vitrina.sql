-- витрина для всего
IF OBJECT_ID('dbo.DashboardDaily_v2', 'U') IS NOT NULL
  DROP TABLE dbo.DashboardDaily_v2;

SELECT dd.date_key,dd.[date],m.trips_cnt,m.revenue_total,m.avg_total_amount,m.avg_fare_amount,m.avg_trip_distance,
e.usd_eur_rate,e.avg_rev_per_trip_usd,e.avg_rev_per_trip_eur,e.gdp_usd,m.pm25_avg_value,m.no2_avg_value
INTO dbo.DashboardDaily_v2
FROM dbo.DimDate_v2 dd
JOIN dbo.FactMobilityAirDaily_fxfilled_v2 m ON m.date_key = dd.date_key
JOIN dbo.FactEconomyTaxiDaily_v2 e ON e.date_key = dd.date_key
ORDER BY dd.date_key;

SELECT COUNT(*) AS cnt FROM dbo.DashboardDaily_v2;
SELECT TOP (10) *
FROM dbo.DashboardDaily_v2
ORDER BY date_key;

