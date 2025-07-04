-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
-- MAGIC </div>
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 01 - Writing Queries in Databricks
-- MAGIC
-- MAGIC In this lesson, you'll be learning how to discover data in the catalog explorer and use Databricks Notebooks to develop queries for exploration and manipulation of that data. 
-- MAGIC
-- MAGIC This lesson uses the resources available in the  `dbacademy_retail` catalog. Usage of these resources will be explained as they are encountered in the following instructions.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 1: Data Discovery
-- MAGIC The first thing you'll need to complete any data analytics task is the appropriate data for the request. To find the right data, you'll need to use the Catalog Explorer or the Databricks Search to locate the data for this project. To use the Catalog Explorer, follow the steps below.
-- MAGIC
-- MAGIC - Step 1: Select **Catalog** from the sidebar navigation.
-- MAGIC - Step 2: In the catalog selector, locate the catalog titled: **dbacademy_retail**. You can also use the search at the top to narrow down the available options.
-- MAGIC - Step 3: Expand the **v01** schema. You should see three tables in this schema.
-- MAGIC     - customers
-- MAGIC     - sales
-- MAGIC     - sales_orders
-- MAGIC
-- MAGIC You'll notice this schema also has a volume. The volume contains the associated CSV files that correspond to the tables. You can create data tables from files located in a volume, but that is outside the scope of this content.
-- MAGIC
-- MAGIC Now we have our data for this lesson.
-- MAGIC
-- MAGIC ---

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 2: Using Notebooks for SQL Development
-- MAGIC
-- MAGIC Navigate to the **01 - Writing Queries in Databricks** Notebook, **Part 2**. This is where you'll begin writing queries and exploring the data identified in Part 1.
-- MAGIC
-- MAGIC With the notebook open, confirm it has been connected to a running compute cluster. This should be a Serverless Databricks SQL Warehouse. 
-- MAGIC
-- MAGIC SQL Warehouses are designed specifically for optimizing SQL workloads. Serverless offers the best price for performance in Databricks, but if regulatory requirements dictate you use a non-serverless compute option, Databricks offers a Pro version of the Databricks SQL Warehouse. However, while the Pro Databricks SQL Warehouse is enterprise ready and optimized for performance at scale, it doesn't offer the same start up speed or scalability as Databricks Serverless compute.
-- MAGIC
-- MAGIC #### Run Setup (REQUIRED)
-- MAGIC We need **dbacademy_retail** schema for this which we can deploy from **Databrics MarketPlace**.
-- MAGIC - Left side menu, cluck on **MarketPlace**
-- MAGIC - Search **Simulated Retail Customer Data** and follow instruction to install it in below screenshots
-- MAGIC
-- MAGIC ![Market Place - Search Sample Retail Customer Data](./Images/DBR-Marketplace-SimulatedRetailCustomerData_1.png)
-- MAGIC
-- MAGIC ![Market Place - Install Sample Retail Customer Data](./Images/DBR-Marketplace-SimulatedRetailCustomerData_2.png)
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Now, you need a cell in the notebook to write your code. Use the **+Code** button directly below this text to create a new cell. You may need to move your mouse over the space between this cell and the next to see the **+Code** button.
-- MAGIC
-- MAGIC Copy and paste the following SQL command into the cell you created.
-- MAGIC
-- MAGIC `SHOW TABLES IN dbacademy_retail.v01;`

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Now, add another code cell below that one and enter the following SQL command.
-- MAGIC
-- MAGIC `SELECT * FROM dbacademy_retail.v01.customers;`
-- MAGIC
-- MAGIC You have the option to run each cell one-by-one, as you did for the notebook setup, or you can select the "Run All" option at the top of the notebook to execute all the cells in the notebook in sequence. 
-- MAGIC
-- MAGIC **Three Level Namespace:** As you may have noticed, in order to reference the data tables for this lesson, we used a three level namespace `catalog.schema.table`.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC **Note:** In this notebook, new cells are SQL by default, as noted in the upper right corner. This is because the notebook itself is set to SQL, as indicated next to the notebook name at the top of the window. These toggles allow you to change the code type of the notebook or cells. When you select an option other than the notebook default, Python for example, an indicator (e.g. %python or %md) is added to the cell, indicating it will run as a different type of code. SQL Warehouses have been optimized for SQL only and will not execute anything else. So notebooks connected to a SQL Warehouse should only contain SQL or markdown cells to prevent encountering an error.
-- MAGIC
-- MAGIC ---

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 3: Use Cell Focus Mode in Notebooks
-- MAGIC
-- MAGIC Now, we'll discuss **Focus Mode**. Focus mode allows you to expand a cell with a half screen results panel. Using the **Focus Mode** icon in the right corner of the following cell, open the cell in focus mode and follow the details available in the comments.

-- COMMAND ----------

-- MAGIC %run ./Setup/setup

-- COMMAND ----------

-- Take a moment to explore Focus mode. You can do the following:
-- * Navigate between cells
-- * Toggle Assistant
-- * Review cell comments or version history
-- * Expand the Terminal or the Output window.

-- On the left, navigate to the catalog explorer. Use this panel to locate the dbacademy catalog, and locate your own, which is automatically created at start-up and is displayed after running the set-up script earlier in this notebook.

USE CATALOG IDENTIFIER(DA.catalog_name);
USE SCHEMA IDENTIFIER(DA.schema_name);
SELECT current_catalog(), current_schema();

-- This displays your current catalog and schema.
-- When finished, exit focus mode by selecting the Exit Focus Mode button at the top.

-- COMMAND ----------

-- For each table (customers, sales, sales_orders) in the dbacademy_retail.v01 schema, run the following command replacing the table name with each run:

CREATE or REPLACE TABLE customers AS 
SELECT * FROM dbacademy_retail.v01.customers;

-- This creates the tables in your schema.

-- COMMAND ----------

-- Next run this code to view the customers table in your schema.
SELECT * FROM customers;

-- Note this is using the default catalog and schema you set several cells earlier in this notebook.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC In the results panel, you can see data presented as a table.
-- MAGIC
-- MAGIC You are going to create a simple visualization, but please note that we are going to cover visualizations in much more detail later in the course. Complete the following steps:
-- MAGIC
-- MAGIC 1. Click the **+** button in the results section of the query editor, and then select **Visualization**.
-- MAGIC 2. Leave the **Visualization Type** as **Bar**.
-- MAGIC 3. Use the **X column** drop-down to select **state**.
-- MAGIC 4. Click **add column** under the **Y column** header, and select __*__.
-- MAGIC 5. Leave **Count** selected by default.
-- MAGIC 6. Click **Save** in the lower-right corner.
-- MAGIC
-- MAGIC The visualization is added next to the results under the query. Note that you did not have to perform any grouping or aggregation in the query itself, yet the visualization displays a count, grouped by state.
-- MAGIC
-- MAGIC You can now name the visualization by clicking on its title, or edit the visualization by clicking the **Edit Visualization** option under the chart.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
-- MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
-- MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
-- MAGIC <a href="https://help.databricks.com/">Support</a>
