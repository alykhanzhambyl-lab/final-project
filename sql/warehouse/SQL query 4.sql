SELECT TOP 50 *
FROM lake_lakehouse.dbo.gold_fact_air_quality_daily_star_v2
WHERE date_key IS NULL;

SELECT COUNT(*) AS total_rows
FROM lake_lakehouse.dbo.gold_fact_air_quality_daily_star_v2;
