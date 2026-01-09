These SQL scripts are executed in the Fabric Warehouse to build the reporting layer used by Power BI.
They create the star schema and marts that answer the analytics questions (mobility, air quality, correlation over time, and economy/FX).

Why these queries exist
- Build the star schema: dimensions (Date/Zone/FX/GDP) and facts (Taxi/Air Quality).
- Create daily marts for dashboards: city-level joins by date_key (Mobility + Air) and economy metrics (USD/EUR per trip).
- Handle FX gaps: fill missing USD/EUR days and compute revenue in EUR consistently.
- Run QC checks: row counts, null checks, correlations, peak days, weekday vs weekend splits.

Where the scripts live
sql/warehouse/
sql/qc/