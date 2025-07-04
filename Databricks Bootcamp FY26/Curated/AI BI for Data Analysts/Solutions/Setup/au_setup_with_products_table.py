# Databricks notebook source
# MAGIC %sql
# MAGIC USE CATALOG dbacademy;  -- Modify to use DBACADEMY in Vocareum
# MAGIC USE SCHEMA ops;
# MAGIC
# MAGIC -- Creates View of keys + values
# MAGIC CREATE OR REPLACE TEMP VIEW user_info AS
# MAGIC SELECT map_from_arrays(collect_list(key), collect_list(value))
# MAGIC FROM meta;
# MAGIC
# MAGIC -- Creates MAP object of ops table key + values using the view
# MAGIC DECLARE OR REPLACE DA MAP<STRING,STRING>;
# MAGIC SET VAR DA = (SELECT * FROM user_info);
# MAGIC
# MAGIC -- Set default schema for the user  
# MAGIC USE SCHEMA IDENTIFIER(DA.schema_name);
# MAGIC
# MAGIC -- Copy in tables from their masters in Marketplace
# MAGIC
# MAGIC CREATE OR REPLACE TABLE au_opportunities AS 
# MAGIC   SELECT * FROM dbacademy_databricks_simulated_australia_sales_and_opportunities_data.v01.opportunities;
# MAGIC CREATE OR REPLACE TABLE au_orders AS 
# MAGIC   SELECT * FROM dbacademy_databricks_simulated_australia_sales_and_opportunities_data.v01.orders;
# MAGIC CREATE OR REPLACE TABLE au_customers AS 
# MAGIC   SELECT * FROM dbacademy_databricks_simulated_australia_sales_and_opportunities_data.v01.customers;
# MAGIC
# MAGIC DROP TABLE IF EXISTS au_products;
# MAGIC
# MAGIC CREATE TABLE au_products (productid string, productname string, listprice float);
# MAGIC
# MAGIC INSERT INTO
# MAGIC   au_products (productid, productname, listprice)
# MAGIC VALUES
# MAGIC   ('JQ9322', 'TableSaw', 24.99),
# MAGIC   ('A802a', 'Mill', 10.17),
# MAGIC   ('EE05x', 'Press', 363.02),
# MAGIC   ('R9S10', 'Lathe', 43.83),
# MAGIC   ('BC111d', 'Drill', 63.28),
# MAGIC   ('W8931', 'Planer', 45.22),
# MAGIC   ('Q28R3', 'Grinder', 176.33),
# MAGIC   ('MDb304', 'CAD System', 502.80),
# MAGIC   ('OR307p', 'Kazoo', 0.99); 
# MAGIC
# MAGIC -- Show the user their catalog + schema, since they will need to interpolate their schema into lab instructions
# MAGIC SELECT current_catalog() as CourseCatalog, current_schema() as YourSchema;