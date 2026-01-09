These SQL scripts are quick validation / exploration queries executed in the Lakehouse SQL analytics endpoint.
They do not build the final reporting model - they are used to confirm that ingestion and Silver/Gold outputs look correct before moving to the Warehouse star schema and Power BI.

Why these queries exist
- Sanity checks: row counts, NULL checks, basic schema validation.
- Source validation: confirm ECB FX and World Bank GDP are loaded and reasonable.
- OpenAQ QC: verify NYC daily coverage and presence of PM2.5 / NO2.
- Fast debugging: spot issues early without running notebooks again.

Where the scripts live
sql/lakehouse_endpoint/
