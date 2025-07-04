-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
-- MAGIC </div>
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 02 - Using Databricks Assistant
-- MAGIC
-- MAGIC In this lesson, you'll learn how to use Databricks Assistant to support query development and testing. 
-- MAGIC
-- MAGIC This lesson uses the following resources from  `dbacademy_retail.v01`:
-- MAGIC * **sales** table
-- MAGIC * **customers** table
-- MAGIC
-- MAGIC You will also need your `user_specific_schema` from the `dbacademy` catalog.
-- MAGIC
-- MAGIC #### Run Setup (REQUIRED)
-- MAGIC Use the play icon in the cells below to run the set-up for this demonstration and set your catalog and schema for this notebook. This is required to initialize your schema where you'll be making tables and views. Take note of your schema name as you'll need it for a later activity.

-- COMMAND ----------

-- MAGIC %run ./Setup/setup

-- COMMAND ----------

USE CATALOG dbacademy;
USE SCHEMA IDENTIFIER(DA.schema_name);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 1: Writing
-- MAGIC Use Assistant to write a query in the next cell. Selecting the cell below will give you the option to **generate** with AI. Clicking **generate**, you can enter the following prompt:
-- MAGIC
-- MAGIC `Write me a SQL Query for creating a "high sales" view for any sales value over 10000 from the "sales" table in the dbacademy_retail.v01.`
-- MAGIC
-- MAGIC Ensure the resulting code, when executed, creates the view under your user specific schema in the dbacademy catalog.

-- COMMAND ----------



-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Note:** You cannot create a table or view in `dbacademy_retail.v01` so you'll need to edit the query to make the view in your own schema. How would you edit the prompt so that it provides you with a query that makes a schema in your user schema? Create a cell below this one to test your ideas for a better prompt.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC ### Part 2: Debugging
-- MAGIC The next few cells contain incorrectly written queries that will not run. You can use Assistant to help find out what is wrong with the query and re-write it appropriately so it will run. Try running the cell first. Select "Diagnose error" to bring up Databricks Assistant to support troubleshooting the problem.

-- COMMAND ----------

SELECT * dbacademy_retail.v01.sales WHERE

-- COMMAND ----------

SELECT * FROM WHERE column_name = 'total_price';

-- COMMAND ----------

SELECT FROM customers;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC These are all simple examples that can be debugged just by simply reviewing the code, but you can imagine a much more complex query that isn't executing correctly. Databricks Assistant can be a great asset in quickly figuring out what is wrong and providing solutions to correct it.
-- MAGIC
-- MAGIC ---
-- MAGIC **Follow-up Questions:** What other use cases can you think of for using Databricks Assistant to support your data analytic work in Databricks?

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
-- MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
-- MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
-- MAGIC <a href="https://help.databricks.com/">Support</a>