
-- SELECT
--   COUNT(*) AS cnt,
--   COUNT(DISTINCT id) AS distinct_sensor_id,
--   COUNT(DISTINCT location_id) AS distinct_location_id
-- FROM dbo.bronze_openaq_location_sensors_nyc_v2;
-- This query counts the total number of sensor records,
-- the number of unique sensor IDs, and the number of unique location IDs
-- in the bronze_openaq_location_sensors_nyc_v2 table.

-- SELECT COUNT(*) AS orphan_sensors
-- FROM dbo.bronze_openaq_location_sensors_nyc_v2 s
-- LEFT JOIN dbo.bronze_openaq_locations_nyc_v2 l
--   ON s.location_id = l.id
-- WHERE l.id IS NULL;
-- This query identifies "orphan" sensors by counting sensors
-- whose location_id does not match any id in the locations table,
-- indicating sensors linked to non-existent locations.

-- SELECT [parameter.name] AS parameter_name, COUNT(*) AS cnt
-- FROM dbo.bronze_openaq_location_sensors_nyc_v2
-- GROUP BY [parameter.name]
-- ORDER BY cnt DESC;
-- This query groups sensors by their parameter name (pollutant type)
-- and counts how many sensors measure each parameter,
-- ordering the results by count descending.


-- This query checks the presence of specific "ok" sensors by their IDs,
-- summing how many of the listed PM2.5 and NO2 sensor IDs exist in the table.
SELECT
  -- Count how many PM2.5 sensor IDs from the specified list are present
  SUM(CASE WHEN id IN (673,1097,1103,1128,1143,1145,1152,1534,1758,1761,25520) THEN 1 ELSE 0 END) AS pm25_ok_present,
  -- Count how many NO2 sensor IDs from the specified list are present
  SUM(CASE WHEN id IN (1535,2644,3638,3951,23341) THEN 1 ELSE 0 END) AS no2_ok_present
FROM dbo.bronze_openaq_location_sensors_nyc_v2;
 
