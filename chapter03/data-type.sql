-- Query the PostgreSQL system catalog for the supported data types:

SELECT t.typname
FROM   pg_catalog.pg_type AS t
WHERE  t.typelem  = 0      -- disregard array element types
  AND  t.typrelid = 0;     -- list non-composite types only
