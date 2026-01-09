--counts (dims + facts)
SELECT 'DimDate_v2' AS t, COUNT(*) AS cnt FROM dbo.DimDate_v2
UNION ALL SELECT 'DimZone_v2', COUNT(*) FROM dbo.DimZone_v2
UNION ALL SELECT 'DimFX_v2', COUNT(*) FROM dbo.DimFX_v2
UNION ALL SELECT 'DimGDP_v2', COUNT(*) FROM dbo.DimGDP_v2
UNION ALL SELECT 'FactTaxiDaily_v2', COUNT(*) FROM dbo.FactTaxiDaily_v2
UNION ALL SELECT 'FactTaxiZoneDaily_v2', COUNT(*) FROM dbo.FactTaxiZoneDaily_v2
UNION ALL SELECT 'FactAirQualityDaily_v2', COUNT(*) FROM dbo.FactAirQualityDaily_v2;