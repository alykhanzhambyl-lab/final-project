-- FactTaxiDaily
IF OBJECT_ID('dbo.FactTaxiDaily_v2','U') IS NOT NULL TRUNCATE TABLE dbo.FactTaxiDaily_v2;

INSERT INTO dbo.FactTaxiDaily_v2
SELECT date_key,trips_cnt,revenue_total,avg_total_amount,avg_fare_amount,avg_trip_distance,usd_eur_rate,revenue_eur,gdp_usd
FROM lake_lakehouse.dbo.gold_fact_taxi_daily_star_v2
WHERE date_key IS NOT NULL;

-- FactTaxiZoneDaily
IF OBJECT_ID('dbo.FactTaxiZoneDaily_v2','U') IS NOT NULL TRUNCATE TABLE dbo.FactTaxiZoneDaily_v2;

INSERT INTO dbo.FactTaxiZoneDaily_v2
SELECT date_key,CAST(PULocationID AS INT),trips_cnt,revenue_total,avg_total_amount,usd_eur_rate,revenue_eur,pu_borough,pu_zone,pu_service_zone
FROM lake_lakehouse.dbo.gold_fact_taxi_zone_daily_star_v2
WHERE date_key IS NOT NULL;

-- FactAirQualityDaily
IF OBJECT_ID('dbo.FactAirQualityDaily_v2','U') IS NOT NULL DROP TABLE dbo.FactAirQualityDaily_v2;
CREATE TABLE dbo.FactAirQualityDaily_v2 (
  date_key INT NOT NULL,
  location_id BIGINT NULL,
  parameter_name VARCHAR(50) NULL,
  avg_value FLOAT NULL,
  min_value FLOAT NULL,
  max_value FLOAT NULL,
  obs_cnt BIGINT NULL
);

-- загрузить
INSERT INTO dbo.FactAirQualityDaily_v2
SELECT date_key,CAST(location_id AS BIGINT),parameter_name,avg_value,min_value,max_value,obs_cnt
FROM lake_lakehouse.dbo.gold_fact_air_quality_daily_star_v2
WHERE date_key IS NOT NULL;

