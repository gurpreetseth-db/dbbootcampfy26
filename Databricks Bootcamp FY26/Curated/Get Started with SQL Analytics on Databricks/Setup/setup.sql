-- Databricks notebook source
USE CATALOG dbacademy;  -- Modify to use DBACADEMY in Vocareum
USE SCHEMA ops;

-- Creates View of keys + values
CREATE OR REPLACE TEMP VIEW user_info AS
SELECT map_from_arrays(collect_list(key), collect_list(value))
FROM meta;

-- Creates MAP object of ops table key + values using the view
DECLARE OR REPLACE DA MAP<STRING,STRING>;
SET VAR DA = (SELECT * FROM user_info);

-- Set default schema for the user
USE SCHEMA IDENTIFIER(DA.schema_name);

-- Show the user their catalog + schema (I think it's nice to see)
SELECT current_catalog() as CourseCatalog, current_schema() as YourSchema;

-- COMMAND ----------

