-- SELECT TOP 5 *
-- FROM lake_lakehouse.dbo.gold_dim_date_v2;

-- DimDate
IF OBJECT_ID('dbo.DimDate_v2','U') IS NOT NULL DROP TABLE dbo.DimDate_v2;
CREATE TABLE dbo.DimDate_v2 (
  date_key INT NOT NULL,
  [date] DATE NOT NULL,
  [year] INT NOT NULL,
  [month] INT NOT NULL,
  [day] INT NOT NULL,
  dow INT NOT NULL
);

INSERT INTO dbo.DimDate_v2 (date_key,[date],[year],[month],[day],dow)
SELECT date_key,[date],[year],[month],[day],dow
FROM lake_lakehouse.dbo.gold_dim_date_v2;

-- DimZone
IF OBJECT_ID('dbo.DimZone_v2','U') IS NOT NULL DROP TABLE dbo.DimZone_v2;
CREATE TABLE dbo.DimZone_v2 (
  LocationID INT NOT NULL,
  Borough VARCHAR(100) NULL,
  Zone VARCHAR(200) NULL,
  service_zone VARCHAR(100) NULL
);

INSERT INTO dbo.DimZone_v2 (LocationID,Borough,Zone,service_zone)
SELECT CAST(LocationID AS INT), Borough, Zone, service_zone
FROM lake_lakehouse.dbo.gold_dim_zone_v2;

-- DimFX
IF OBJECT_ID('dbo.DimFX_v2','U') IS NOT NULL DROP TABLE dbo.DimFX_v2;
CREATE TABLE dbo.DimFX_v2 (
  date_key INT NOT NULL,
  [date] DATE NOT NULL,
  usd_eur_rate FLOAT NULL
);

INSERT INTO dbo.DimFX_v2 (date_key,[date],usd_eur_rate)
SELECT date_key, [date], usd_eur_rate
FROM lake_lakehouse.dbo.gold_dim_fx_v2;

-- DimGDP
IF OBJECT_ID('dbo.DimGDP_v2','U') IS NOT NULL DROP TABLE dbo.DimGDP_v2;
CREATE TABLE dbo.DimGDP_v2 (
  [year] INT NOT NULL,
  gdp_usd FLOAT NULL
);

INSERT INTO dbo.DimGDP_v2 ([year], gdp_usd)
SELECT [year], gdp_usd
FROM lake_lakehouse.dbo.gold_dim_gdp_v2;


-- QC counts
SELECT 'DimDate_v2' AS t, COUNT(*) AS cnt FROM dbo.DimDate_v2
UNION ALL SELECT 'DimZone_v2', COUNT(*) FROM dbo.DimZone_v2
UNION ALL SELECT 'DimFX_v2', COUNT(*) FROM dbo.DimFX_v2
UNION ALL SELECT 'DimGDP_v2', COUNT(*) FROM dbo.DimGDP_v2

