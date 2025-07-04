# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
# MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
# MAGIC </div>
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC %md
# MAGIC
# MAGIC
# MAGIC
# MAGIC ## AI/BI for Data Analysts
# MAGIC
# MAGIC In this course, you’ll learn how to use the features Databricks provides for business intelligence needs: AI/BI Dashboards and AI/BI Genie. As a Databricks Data Analyst, you will be tasked with creating AI/BI Dashboards and AI/BI Genie Spaces within the platform, managing the access to these assets by stakeholders and necessary parties, and maintaining these assets as they are edited, refreshed, or decommissioned over the course of their lifespan. This course intends to instruct participants on how to design dashboards for business insights, share those with collaborators and stakeholders, and maintain those assets within the platform. Participants will also learn how to utilize AI/BI Genie Spaces to support self-service analytics through the creation and maintenance of these environments powered by the Databricks Data Intelligence Engine.
# MAGIC
# MAGIC
# MAGIC
# MAGIC
# MAGIC ## Course Agenda
# MAGIC | Module &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Lessons &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
# MAGIC |:----:|-------|
# MAGIC | **[M01 - Dashboards and Visualizations in Databricks]($./M01 - Dashboards and Visualizations in Databricks)** | **Lecture -** Introduction and Overview </br> **Lecture -** AI/BI Dashboards </br> **Lecture -** Just enough SQL </br> [**1.04 - Demo** - Designing Datasets for Dashboards]($./M01 - Dashboards and Visualizations in Databricks/1.04 - Demo - Designing Datasets for Dashboards) </br> [**1.05 - Demo** - Creating Visualizations and Adding Summary Statistics to Dashboards]($./M01 - Dashboards and Visualizations in Databricks/1.05 - Demo - Creating Visualizations and Adding Summary Statistics to Dashboards) </br> [**1.06 - Demo** - AI-Enhanced Features]($./M01 - Dashboards and Visualizations in Databricks/1.06 - Demo - AI-Enhanced Features) </br> [**1.07 - Demo** - Filters]($./M01 - Dashboards and Visualizations in Databricks/1.07 - Demo - Filters) </br> [**1.08 - Demo** - Sharing Dashboards with Stakeholders and Others]($./M01 - Dashboards and Visualizations in Databricks/1.08 - Demo - Sharing Dashboards with Stakeholders and Others) </br> [**1.09 - Demo** - Managing Dashboards in Production]($./M01 - Dashboards and Visualizations in Databricks/1.09 - Demo - Managing Dashboards in Production) </br> [**1.10 - Lab** - Dashboard and Visualization Lab Activity]($./M01 - Dashboards and Visualizations in Databricks/1.10 - Lab - Dashboard and Visualization Lab Activity) | 
# MAGIC | **[M02 - AI-BI Genie]($./M02 - AI-BI Genie)** | **Lecture -** Introduction and Overview </br> **Lecture -** AI/BI Genie </br> [**2.03 - Demo** - Developing Genie Spaces]($./M02 - AI-BI Genie/2.03 - Demo - Developing Genie Spaces) </br> [**2.04 - Demo** - Sharing Genie Spaces]($./M02 - AI-BI Genie/2.04 - Demo - Sharing Genie Spaces) </br> [**2.05 - Demo** - Maintaining Genie Spaces]($./M02 - AI-BI Genie/2.05 - Demo - Maintaining Genie Spaces) </br> [**2.06 - Lab** - AI-BI Genie Space Development Activity Lab]($./M02 - AI-BI Genie/2.06 - Lab - AI-BI Genie Space Development Activity Lab)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC
# MAGIC ## Requirements
# MAGIC
# MAGIC Please review the following requirements before starting the lesson:
# MAGIC
# MAGIC * To run demo and lab notebooks, you need to use the **Serverless compute**, which is enabled by default.

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
# MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
# MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
# MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
# MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
# MAGIC <a href="https://help.databricks.com/">Support</a>