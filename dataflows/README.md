Data ingestion files contain the Power Query (M) logic extracted from the Dataflows Gen2 used in this project.
We used Dataflows Gen2 for two sources: World Bank GDP (USA only) and ECB USD/EUR FX.
For OpenAQ we did not use Dataflow Gen2 — ingestion and transformations were implemented in a Fabric Notebook.
For NYC Taxi Parquet ingestion we used a Pipeline (Copy Data) to land files into the Lakehouse.

I am not exporting or versioning the full Fabric Dataflow Gen2 objects and Pipelines in this repository, because they are workspace-managed artifacts tightly coupled to Fabric UI, connections, and tenant settings.

Why these processes are used in Fabric
- Dataflows Gen2: low-code ingestion for API/CSV sources, easy JSON-to-table shaping, and scheduled refresh (used for GDP and FX).
- Notebook: flexible code-based ingestion and transformations where API logic is more complex (used for OpenAQ).
- Pipeline (Copy Data): reliable file ingestion/orchestration into Lakehouse Files for large Parquet datasets (used for NYC Taxi).
