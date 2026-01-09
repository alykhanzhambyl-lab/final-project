
-- Retrieve the schema and table names for all tables
-- in the 'dbo' schema from the database's information schema
SELECT 
    TABLE_SCHEMA,  -- The schema that the table belongs to
    TABLE_NAME     -- The name of the table
FROM 
    INFORMATION_SCHEMA.TABLES
WHERE 
    -- Filter to include only tables in the 'dbo' schema
    TABLE_SCHEMA = 'dbo'
-- Order the results alphabetically by table name
ORDER BY 
    TABLE_NAME;
 
