-- дни без курса/евро-выручки в витрине
SELECT date_key,trips_cnt, revenue_total,  usd_eur_rate,revenue_eur
FROM dbo.FactMobilityAirDaily_v2
WHERE usd_eur_rate IS NULL OR revenue_eur IS NULL
ORDER BY date_key;

SELECT TOP (10) *
FROM dbo.DimFX_v2
ORDER BY date_key;

SELECT
  c.ORDINAL_POSITION, c.COLUMN_NAME, c.DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA='dbo' AND c.TABLE_NAME='DimFX_v2'
ORDER BY c.ORDINAL_POSITION;



