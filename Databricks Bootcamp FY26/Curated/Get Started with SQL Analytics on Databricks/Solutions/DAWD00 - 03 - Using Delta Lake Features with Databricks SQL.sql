-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
-- MAGIC </div>
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 03 - Using Delta Lake Features with Databricks SQL
-- MAGIC
-- MAGIC In this lesson, you'll be exploring some of the features Delta Lakes offers for working with tables in Databricks SQL. To do this, we'll walk through the process of creating a table and manipulating it, then viewing the results in the log. 
-- MAGIC
-- MAGIC You will need your `user_specific_schema` from the `dbacademy` catalog.
-- MAGIC
-- MAGIC #### Run Setup (REQUIRED)
-- MAGIC Use the play icon in the cell below to run the set-up for this demonstration. This is required to initialize your schema where you'll be making tables and views. Take note of your schema name as you'll need it for a later activity.
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %run ./Setup/setup

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Part 1: Create Table and Add Data
-- MAGIC First, we'll create a table in your schema called **delta_students**.

-- COMMAND ----------

USE CATALOG dbacademy;
USE SCHEMA IDENTIFIER(DA.schema_name);

CREATE
OR REPLACE TABLE delta_students (
  id BIGINT GENERATED ALWAYS AS IDENTITY,
  name STRING,
  grade FLOAT,
  country STRING
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC The ID field is type **BIGINT** and its value is automatically generated as a monotonically incremental number. It can be considered as the primary key for the table, as we never pass this value during an **INSERT**.
-- MAGIC
-- MAGIC Next, we'll insert some values and review the data.

-- COMMAND ----------

INSERT INTO
  delta_students (name, grade, country)
VALUES
  ('Lucas', 4.0, "Italy"),
  ("Ana", 3.5, "Germany");

SELECT
  *
FROM
  delta_students;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Then, we'll add some additional records to the table.

-- COMMAND ----------

INSERT INTO
  delta_students (name, grade, country)
VALUES
  ('Mary', 2.0, "Finland"),
  ("John", 3.5, "USA"),
  ("Judith", 4.0, "Singapore");

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Next, we'll make some updates to the data. We'll change the country for one student and edit the grade of another. Finally, we'll view the current data set as it is now.

-- COMMAND ----------

UPDATE
  delta_students
SET
  country = "France"
WHERE
  name = 'Lucas';

UPDATE
  delta_students
SET
  grade = 2.5
WHERE
  id = 3;

SELECT
  *
FROM
  delta_students
ORDER BY
  id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Part 2: DESCRIBE HISTORY & VERSION AS OF
-- MAGIC Let's take a closer look at the table's metadata by exploring it through the use of **DESCRIBE HISTORY** and **VERSION AS OF**.
-- MAGIC
-- MAGIC To begin, we'll use **DESCRIBE HISTORY** to review the history of the `delta_students` table.

-- COMMAND ----------

DESCRIBE HISTORY delta_students;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC As you can see in the history, every change and insert we made is logged alongside the optimization automatically executed on the table by Delta. You can use **VERSION AS OF** to view how the data looked at a given version from the history table. 
-- MAGIC
-- MAGIC So let's take a look at the table as of **Version 1** where we inserted the first two records.

-- COMMAND ----------

SELECT * FROM delta_students VERSION AS OF 1 ORDER BY id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Then take a look at **Version 2**.

-- COMMAND ----------

SELECT * FROM delta_students VERSION AS OF 2 ORDER BY id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC But if we look at where the student with ID 1 is located, they are still in Italy, despite having been moved to France during one of the updates. The next command shows the current table.

-- COMMAND ----------

SELECT * FROM delta_students WHERE id = 1;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Step 3: RESTORE TABLE
-- MAGIC
-- MAGIC Suppose something happened to the table. Perhaps a coworker made a mistake and deletes all the records in the table.

-- COMMAND ----------

DELETE FROM delta_students;

-- COMMAND ----------

SELECT * FROM delta_students;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC So now we need to fix the issue before any downline report that depends on the table is run. So using **DESCRIBE HISTORY**, find the version before the **DELETE** occurred.

-- COMMAND ----------

DESCRIBE HISTORY delta_students;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC According to the version list, the last update was Version 5, so we'll use that to restore the table back to that version using the **RESTORE TABLE** command.

-- COMMAND ----------

RESTORE TABLE delta_students VERSION AS OF 5;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC So now when we check the table, it's back to how it was before our coworker deleted it accidentally.

-- COMMAND ----------

SELECT * FROM delta_students ORDER BY id;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC #### Conclusion
-- MAGIC
-- MAGIC As you can see, Delta offers several benefits to working with tables including the ability to step back in time to restore the table to previous states in case something were to happen.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
-- MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
-- MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
-- MAGIC <a href="https://help.databricks.com/">Support</a>