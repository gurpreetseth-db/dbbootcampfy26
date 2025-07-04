# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
# MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
# MAGIC </div>
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC # Ingesting Data into Delta Lake

# COMMAND ----------

# MAGIC %md
# MAGIC ## Classroom Setup
# MAGIC
# MAGIC Run the following cell to configure your working environment for this course.
# MAGIC
# MAGIC **NOTE:** The `DA` object is only used in Databricks Academy courses and is not available outside of these courses. It will dynamically reference the information needed to run the course.

# COMMAND ----------

# MAGIC %run ./Includes/Classroom-Setup-02

# COMMAND ----------

# MAGIC %md
# MAGIC ## A. Configure and Explore Your Environment
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####1. Setting Up catalog and Schema
# MAGIC Set the default catalog to **dbacademy** and your unique schema. Then, view the available tables to confirm that no tables currently exist in your schema.

# COMMAND ----------

#Set the catalog and schema

spark.sql(f"USE CATALOG {DA.catalog_name}")
spark.sql(f"USE SCHEMA {DA.schema_name}")

#Display available tables in your schema
spark.sql('SHOW TABLES').display()

# COMMAND ----------

# MAGIC %md
# MAGIC ####2. Viewing the available files
# MAGIC View the available files in your schema's **myfiles** volume. Confirm that only the **employees.csv** file is available.
# MAGIC
# MAGIC **NOTE:** Remember, when referencing data in volumes, use the path provided by Unity Catalog, which always has the following format: */Volumes/catalog_name/schema_name/volume_name/*.

# COMMAND ----------

spark.sql(f"LIST '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/' ").display()

# COMMAND ----------

# MAGIC %md
# MAGIC ## B. Delta Lake Ingestion Techniques
# MAGIC **Objective**: Create a Delta table from the **employees.csv**  file using various methods.
# MAGIC
# MAGIC - CREATE TABLE AS (CTAS)
# MAGIC - UPLOAD UI (User Interface)
# MAGIC - COPY INTO
# MAGIC - AUTOLOADER (Overview only, outside the scope of this module)

# COMMAND ----------

# MAGIC %md
# MAGIC ####1. CREATE TABLE (CTAS)
# MAGIC 1. Create a table from the **employees.csv** file using the CREATE TABLE AS statement similar to the previous demonstration. Run the query and confirm that the **current_employees_ctas** table was successfully created.

# COMMAND ----------


# Drop the table if it exists for demonstration purposes
spark.sql('DROP TABLE IF EXISTS current_employees_ctas')

# Create the table using CTAS
spark.sql(f'''
CREATE TABLE current_employees_ctas
AS
SELECT ID, FirstName, Country, Role 
FROM read_files(
  '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/',
  format => 'csv',
  header => true,
  inferSchema => true
 )
''')

# Display available tables in your schema
spark.sql('SHOW TABLES').display()

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC **Note:** In a Serverless environment, executing the `CREATE OR REPLACE TEMP VIEW` command may result in an insufficient privileges error.

# COMMAND ----------


# ALTERNATE METHOD: Create a temp view for the CTAS statement

# Drop the table if it exists for demonstration purposes
spark.sql('DROP TABLE IF EXISTS current_employees_ctas')


# Create temporary view
spark.sql(f'''
CREATE OR REPLACE TEMP VIEW vw_current_employees 
USING CSV
OPTIONS (
  path '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/',
  header = 'true',
  delimiter = ','
 )
''')

# Use temporary view in CTAS statement to create the table
spark.sql('''CREATE OR REPLACE TABLE current_employees_ctas AS
SELECT *
FROM vw_current_employees''').display()

# COMMAND ----------

# MAGIC %md
# MAGIC NOTE: You might encounter insufficient permission using serverless compute

# COMMAND ----------

# MAGIC %md
# MAGIC 2. Query the **current_employees_ctas** table and confirm that it contains 4 rows and 4 columns.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT *
# MAGIC FROM current_employees_ctas;

# COMMAND ----------

# MAGIC %md
# MAGIC ####2. UPLOAD UI
# MAGIC The add data UI allows you to manually load data into Databricks from a variety of sources.

# COMMAND ----------

# MAGIC %md
# MAGIC 1. Complete the following steps to manually download the **employees.csv** file from your volume:
# MAGIC - a. Select the Catalog icon in the left navigation bar. 
# MAGIC - b. Click on the your module catalog **(YOUR LAB USER)**
# MAGIC - c. Select the refresh icon to refresh the **YOUR LAB USER** catalog.
# MAGIC - d. Expand the **YOUR LAB USER** catalog. Within the catalog, you should see a variety of schemas (databases).
# MAGIC - e. Expand your schema. You can locate your schema in the setup notes in the first cell or in the top widget bar under the **my_schema** parameter. Notice that your schema contains **Tables** and **Volumes**.
# MAGIC - f. Expand **Volumes** then **myfiles**. The **myfiles** volume should contain a single CSV file named **employees.csv**. 
# MAGIC - g. Click on the kebab menu on the right-hand side of the **employees.csv** file and select **Download Volume file.** This will download the CSV file to your browser's download folder.

# COMMAND ----------

# MAGIC %md
# MAGIC 2. Complete the following steps to manually upload the **employees.csv** file to your schema:
# MAGIC - a. In the navigation bar select your schema. 
# MAGIC - b. Select the **Create** drop down icon , and select **Create table**.
# MAGIC - c. Select the **employees.csv** you downloaded earlier into the available section in the browser, or select **browse**, navigate to your downloads folder and select the **employees.csv** file.

# COMMAND ----------

# MAGIC %md
# MAGIC 3. Complete the following steps to create the Delta table using the UPLOAD UI.
# MAGIC - a. In the UI confirm the table will be created in the catalog **YOUR LAB USER** and your unique schema. 
# MAGIC - b. Under **Table name**, name the table **current_employees_ui**.
# MAGIC - c. Select the **Create table** icon at the bottom of the screen to create the table.
# MAGIC - d. Confirm the table was created successfully. Then close out of the Catalog Explorer browser.
# MAGIC
# MAGIC <br></br>
# MAGIC **Example**
# MAGIC <br></br>
# MAGIC
# MAGIC ![create_table_ui](./Includes/images/UI_Create_Table_1.png)
# MAGIC
# MAGIC
# MAGIC ![create_table_ui](./Includes/images/UI_Create_Table_2.png)

# COMMAND ----------

# MAGIC %md
# MAGIC 4. Use the SHOW TABLES statement to view the available tables in your schema. Confirm that the **current_employees_ui** table has been created. 
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC SHOW TABLES;

# COMMAND ----------

# MAGIC %md
# MAGIC 5. Lastly, query the table to review its contents.
# MAGIC
# MAGIC **NOTE**: If you did not upload the table using the UPLOAD UI and name it **current_employees_ui** an error will be returned.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * 
# MAGIC FROM current_employees_ui;

# COMMAND ----------

# MAGIC %md
# MAGIC ####3. COPY INTO
# MAGIC Create a table from the **employees.csv** file using the [COPY INTO](https://docs.databricks.com/en/sql/language-manual/delta-copy-into.html) statement. The COPY INTO statement loads data from a file location into a Delta table. This is a retryable and idempotent operation — Files in the source location that have already been loaded are skipped. This is true even if the files have been modified since they were loaded

# COMMAND ----------

# MAGIC %md
# MAGIC 1. Create an empty table named **current_employees_copyinto** and define the column data types.

# COMMAND ----------

# MAGIC %sql
# MAGIC -- Drop the table if it exists for demonstration purposes
# MAGIC DROP TABLE IF EXISTS current_employees_copyinto;
# MAGIC
# MAGIC -- Create an empty table with the column data types
# MAGIC CREATE TABLE current_employees_copyinto (
# MAGIC   ID INT,
# MAGIC   FirstName STRING,
# MAGIC   Country STRING,
# MAGIC   Role STRING
# MAGIC );

# COMMAND ----------

# MAGIC %md
# MAGIC 2. Use the COPY INTO statement to load all files from the **myfiles** volume (currently only the **employees.csv** file exists) using the path provided by Unity Catalog. Confirm that the data is loaded into the **current_employees_copyinto** table.
# MAGIC    
# MAGIC     Confirm the following:
# MAGIC     - **num_affected_rows** is 4
# MAGIC     - **num_inserted_rows** is 4
# MAGIC     - **num_skipped_correct_files** is 0

# COMMAND ----------

spark.sql(f'''
COPY INTO current_employees_copyinto
  FROM '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/'
  FILEFORMAT = CSV
  FORMAT_OPTIONS ('header' = 'true', 'inferSchema' = 'true')
  ''').display()

# COMMAND ----------

# MAGIC %md
# MAGIC 3. Query the **current_employees_copyinto** table and confirm that all 4 rows have been copied into the Delta table correctly.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * 
# MAGIC FROM current_employees_copyinto;

# COMMAND ----------

# MAGIC %md
# MAGIC 4. Run the COPY INTO statement again and confirm that it did not re-add the data from the volume that was already loaded. Remember, COPY INTO is a retryable and idempotent operation — Files in the source location that have already been loaded are skipped.   
# MAGIC - **num_affected_rows** is 0
# MAGIC - **num_inserted_rows** is 0
# MAGIC - **num_skipped_correct_files** is 0
# MAGIC
# MAGIC

# COMMAND ----------

spark.sql(f'''
COPY INTO current_employees_copyinto
  FROM '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/'
  FILEFORMAT = CSV
  FORMAT_OPTIONS ('header' = 'true', 'inferSchema' = 'true')
  ''').display()

# COMMAND ----------

# MAGIC %md
# MAGIC 5. Run the script below to create an additional CSV file named **employees2.csv** in your **myfiles** volume. View the results and confirm that your volume now contains two CSV files: the original **employees.csv** file and the new **employees2.csv** file.

# COMMAND ----------


## Create the new employees2.csv file in your volume
DA.create_employees_csv2()

## View the files in the your myfiles volume
files = dbutils.fs.ls(f'/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles')
display(files)

# COMMAND ----------

# MAGIC %md
# MAGIC 6. Query the new **employees2.csv** file directly. Confirm that only 2 rows exist in the CSV file.

# COMMAND ----------

spark.sql(f'''
SELECT ID, FirstName, Country, Role 
FROM read_files(
  '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/employees2.csv',
  format => 'csv',
  header => true,
  inferSchema => true
 )
''').display()

# COMMAND ----------

# MAGIC %md
# MAGIC 7. Execute the COPY INTO statement again using your volume's path. Notice that only the 2 rows from the new **employees2.csv** file are added to the **current_employees_copyinto** table.
# MAGIC
# MAGIC - **num_affected_rows** is 2
# MAGIC - **num_inserted_rows** is 2
# MAGIC - **num_skipped_correct_files** is 0

# COMMAND ----------

spark.sql(f'''
COPY INTO current_employees_copyinto
  FROM '/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/'
  FILEFORMAT = CSV
  FORMAT_OPTIONS ('header' = 'true', 'inferSchema' = 'true')
  ''').display()

# COMMAND ----------

# MAGIC %md
# MAGIC 8. View the updated **current_employees_copyinto** table and confirm that it now contains 6 rows, including the new data that was added.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * 
# MAGIC FROM current_employees_copyinto;

# COMMAND ----------

# MAGIC %md
# MAGIC 9. View table's history. Notice that there are 3 versions.
# MAGIC - **Version 0** is the initial empty table created by the CREATE TABLE statement.
# MAGIC - **Version 1** is the first COPY INTO statement that loaded the **employees.csv** file into the Delta table.
# MAGIC - **Version 2** is the second COPY INTO statement that only loaded the new **employees2.csv** file into the Delta table.

# COMMAND ----------

# MAGIC %sql
# MAGIC DESCRIBE HISTORY current_employees_copyinto;

# COMMAND ----------

# MAGIC %md
# MAGIC ####4. AUTOLOADER
# MAGIC
# MAGIC **NOTE: Auto Loader is outside the scope of this course.**
# MAGIC
# MAGIC Auto Loader incrementally and efficiently processes new data files as they arrive in cloud storage without any additional setup.
# MAGIC
# MAGIC ![autoloader](./Includes/images/Autoloader.png)
# MAGIC
# MAGIC The key benefits of using the auto loader are:
# MAGIC - No file state management: The source incrementally processes new files as they land on cloud storage. You don't need to manage any state information on what files arrived.
# MAGIC - Scalable: The source will efficiently track the new files arriving by leveraging cloud services and RocksDB without having to list all the files in a directory. This approach is scalable even with millions of files in a directory.
# MAGIC - Easy to use: The source will automatically set up notification and message queue services required for incrementally processing the files. No setup needed on your side.
# MAGIC
# MAGIC Check out the documentation
# MAGIC [What is Auto Loader](https://docs.databricks.com/en/ingestion/auto-loader/index.html) for more information.

# COMMAND ----------

# Optional: write autoloader statement to load sales records

# Import functions
from pyspark.sql.functions import input_file_name, current_timestamp

# Define variables used in code below
file_path = f'/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/'
table_name = f"employees_autoloader"
checkpoint_path = f"/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/_checkpoint/etl_quickstart"

# Clear out data from previous demo execution
spark.sql(f"DROP TABLE IF EXISTS {table_name}")
dbutils.fs.rm(checkpoint_path, True)

# COMMAND ----------

from pyspark.sql.functions import col# Configure Auto Loader to ingest CSV data to a Delta table

(spark.readStream
  .format("cloudFiles")
  .option("cloudFiles.format", "csv")
  .option("cloudFiles.schemaLocation", checkpoint_path)
  .load(file_path)
  .select("*", current_timestamp().alias("processing_time")).withColumn("File_Name", col("_metadata.file_path"))
  .writeStream
  .option("checkpointLocation", checkpoint_path)
  .trigger(availableNow=True)
  .toTable(table_name))

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from employees_autoloader
# MAGIC --select count(*) from employees_autoloader

# COMMAND ----------

# MAGIC %md
# MAGIC ## C. Cleanup
# MAGIC 1. Drop your demonstration tables.

# COMMAND ----------

# MAGIC %sql
# MAGIC DROP TABLE IF EXISTS current_employees_ctas;
# MAGIC DROP TABLE IF EXISTS current_employees_ui;
# MAGIC DROP TABLE IF EXISTS current_employees_copyinto;
# MAGIC DROP TABLE IF EXISTS employees_autoloader;
# MAGIC DROP VIEW IF EXISTS vw_current_employees;
# MAGIC SHOW TABLES;

# COMMAND ----------

# MAGIC %md
# MAGIC 2. Drop the **employees2.csv** file.

# COMMAND ----------

## Remove employees2.csv from the myfiles volume
dbutils.fs.rm(f"/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/employees2.csv")

# COMMAND ----------

## Remove checkpoint directory from the myfiles volume
dbutils.fs.rm(f"/Volumes/{DA.catalog_name}/{DA.schema_name}/myfiles/_checkpoint", recurse=True)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
# MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
# MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
# MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
# MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
# MAGIC <a href="https://help.databricks.com/">Support</a>
