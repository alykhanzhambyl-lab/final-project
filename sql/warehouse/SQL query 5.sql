-- роверка факта воздуха по параметрам
SELECT parameter_name, COUNT(*) AS cnt
FROM dbo.FactAirQualityDaily_v2
GROUP BY parameter_name
ORDER BY cnt DESC;

-- топ-10 зон по числу поездок за месяц (для mobility dashboard)
SELECT TOP 10 z.Borough, z.Zone, SUM(f.trips_cnt) AS trips_month
FROM dbo.FactTaxiZoneDaily_v2 f
JOIN dbo.DimZone_v2 z ON f.PULocationID = z.LocationID
GROUP BY z.Borough, z.Zone
ORDER BY trips_month DESC;
