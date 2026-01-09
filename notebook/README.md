These notebooks capture the end-to-end logic of the Unified Analytics Platform (Fabric) v2: ingestion, cleaning, standardization (Silver), and publishing analytics-ready tables (Gold + Warehouse).
They are included to make the project reproducible and reviewable, without storing any `dbo.*` data or large raw datasets in Git.

What these notebooks are for
- Provide a code-based, transparent implementation of the transformations that produce the final `_v2` tables.
- Keep the architecture extensible: each notebook focuses on a clear stage (ingestion / Silver / Gold), so new sources or new dimensions/facts can be added without rewriting everything.
- Avoid N+1 patterns by building daily-grain aggregates and star-schema-ready tables instead of row-by-row lookups.

Notebook roles:
1) check_parquet: validates NYC Taxi Parquet files in Lakehouse Files (schema, partitions, basic sanity checks).
2) nyc_union: unifies Yellow + Green taxi datasets into a single canonical trips table and derives daily and zone-daily aggregates.
3) openaq_ingestion_v2: ingests OpenAQ daily data for NYC (PM2.5, NO2) into Bronze tables and performs initial validation.
4) silver_openaq: cleans and standardizes OpenAQ into a Silver daily dataset suitable for joins by date.
5) silver_efx: prepares Silver daily FX (USD/EUR) and GDP (USA) datasets for downstream reporting.
6) gold_dim: builds Gold dimensions (Date, Zone, FX, GDP) using consistent keys (date_key = YYYYMMDD).
7) gold_airqual: publishes Gold air quality facts (daily) aligned to DimDate_v2.
8) gold_mobility: publishes Gold taxi facts (daily and zone-daily) and aligns them to dimensions for reporting.

Outputs produced by notebooks
- Lakehouse tables in dbo schema with suffix `_v2` across Bronze/Silver/Gold layers.
- Gold tables designed to be loaded into the Warehouse star schema for Power BI.

Execution notes
- Expected period: 2019-01.
- Run notebooks in the numeric order above for a clean rebuild.
- Dataflows Gen2 and Pipelines are not versioned here; only notebook logic and SQL scripts are versioned.
