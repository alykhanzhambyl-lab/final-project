-- финалочка
-- Сводка KPI за месяц
SELECT
  COUNT(*) AS n_days,AVG(avg_rev_per_trip_usd) AS mean_usd_per_trip,
  MIN(avg_rev_per_trip_usd) AS min_usd_per_trip,MAX(avg_rev_per_trip_usd) AS max_usd_per_trip,
  AVG(avg_rev_per_trip_eur) AS mean_eur_per_trip,MIN(avg_rev_per_trip_eur) AS min_eur_per_trip,MAX(avg_rev_per_trip_eur) AS max_eur_per_trip,
  AVG(usd_eur_rate) AS mean_fx,MIN(usd_eur_rate) AS min_fx,MAX(usd_eur_rate) AS max_fx
FROM dbo.FactEconomyTaxiDaily_v2;

--  топ-5 дней: USD/поездку и EUR/поездку
SELECT TOP (5) date_key, trips_cnt, usd_eur_rate, avg_rev_per_trip_usd, avg_rev_per_trip_eur
FROM dbo.FactEconomyTaxiDaily_v2
ORDER BY avg_rev_per_trip_usd DESC;

SELECT TOP (5) date_key, trips_cnt, usd_eur_rate, avg_rev_per_trip_usd, avg_rev_per_trip_eur
FROM dbo.FactEconomyTaxiDaily_v2
ORDER BY avg_rev_per_trip_eur DESC;
