-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
-- MAGIC </div>
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 2.6 Lab - AI/BI Genie Space Development Activity Lab
-- MAGIC
-- MAGIC AI/BI Genie allows business users to conduct self-serve data analytics using natural language and without coding. After a Genie space is set up by a domain expert such as a data analyst, business users can ask their own questions and generate visualizations to help them understand the data. 
-- MAGIC
-- MAGIC In this lesson, you will create and configure a Genie space, experiment with it as if you were an end user and generate feedback, and then return to the administrator's perspective and use that feedback to enhance the space.
-- MAGIC
-- MAGIC This lesson uses the following resources:
-- MAGIC - Tables:
-- MAGIC   - Catalog: dbacademy
-- MAGIC   - Schema: {dynamically named, personal to you}
-- MAGIC   - Tables:
-- MAGIC     - au_customers
-- MAGIC     - au_orders
-- MAGIC     - au_opportunities
-- MAGIC     - au_products
-- MAGIC
-- MAGIC These tables contain simulated business-to-business order and opportunity data for an imaginary company's Australian sales operation. The **au_orders** table contains information from 2021 through the middle of November 2024, and the **au_opportunities** table contains the opportunities present in our company's Customer Relationship Management (CRM) software as of that time. Both of those tables identify the relevant customer with a unique key that points into the **au_customers** table, and both identify the relevant product with a unique key that points into the **au_products** table. You'll use the data in these tables to prepare your Genie space.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC %md
-- MAGIC ### Part 1: Data Discovery
-- MAGIC The first thing you'll need to complete any data analytics task is the appropriate data for the request. To find the right data, you'll need to use the Catalog Explorer or the Databricks Search to locate the data for this project.  In this particular lab exercise, a setup script will copy tables from a Databricks Marketplace share into a schema you control. To get started, click the small triangle Run button in the top left of the cell below.
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC ---

-- COMMAND ----------

-- MAGIC %run "../Setup/au_setup_with_products_table"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC This script clones a few small data tables from a Databricks Marketplace share into your personal schema. At the end it prints out the name of your catalog and your schema. The schema will have a randomly generated name. Make a note of this value. In these instructions, we'll call this simply "your schema."
-- MAGIC
-- MAGIC To use the Databricks Catalog Explorer to see your newly loaded data, follow the steps below.
-- MAGIC
-- MAGIC 1. Select **Catalog** from the sidebar navigation.
-- MAGIC 1. In the catalog selector, locate the catalog titled: **dbacademy**. You can also use the search at the top to narrow down the available options.
-- MAGIC 1. Expand your schema. You should see four tables in this schema.
-- MAGIC     - au_customers
-- MAGIC     - au_orders
-- MAGIC     - au_opportunities
-- MAGIC     - au_products
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 2: Create a Genie Space
-- MAGIC In this part of the lab, we'll start with creating a Genie space directly from the main Databricks user interface.
-- MAGIC 1. Navigate to **Genie** in the left-side navigation of the platform.
-- MAGIC
-- MAGIC 1. Click **+ New** in the upper left corner.
-- MAGIC 1. Select the following tables for the Genie space:
-- MAGIC     - Catalog: dbacademy
-- MAGIC     - Schema: {dynamically named, personal to you}
-- MAGIC     - Tables:
-- MAGIC       - au_customers
-- MAGIC       - au_orders
-- MAGIC       - au_opportunities
-- MAGIC       - au_products
-- MAGIC 1. Click **Create**.
-- MAGIC 1. Under Configure and Settings, fill in the following details about the Genie space:
-- MAGIC     - Title: **Australia Customers, Orders, and Opportunities**
-- MAGIC     - Description:
-- MAGIC       This Genie space allows business users to research our sales performance in Australia
-- MAGIC     - Default warehouse: shared_warehouse
-- MAGIC     - Sample Questions: Enter **How many customers do we have in NSW?** and click **+ Add**. ("NSW" is the standard abbreviation for the Australian state New South Wales.)
-- MAGIC 1. Click **Save**.
-- MAGIC
-- MAGIC
-- MAGIC The Genie space's screen area is split into two sides with the chat window on the left and the configuration and settings on the right. The buttons at the top right allow you to choose among these areas:
-- MAGIC
-- MAGIC * **+ New chat**: Allows you to create a new threaded dialogues with Genie. After you publish a Genie space to end users (who will probably have only "Can View" or "Can Run" access), this is one of the only Genie areas they will have access to.
-- MAGIC * **History** (the icon that looks like a clock): Allows you to review the separate chat threads that you've had with Genie. After you publish a Genie space to end users (who will probably have only "Can View" or "Can Run" access), this is the other Genie area they will have access to.
-- MAGIC * **Configure** (the icon that looks like a gear): Returns you to the edit screen for the settings of the Genie space, much like the screen you saw during the space's creation.
-- MAGIC   Within Configure you'll have:
-- MAGIC   * **Data** (the icon that looks like a stacked blocks): Allows you to review and edit the data tables associated with the Space.
-- MAGIC   * **Instructions** (the icon that looks like a book): Allows you to provide general instructions, in natural language, on how Genie will behave when asked a question by a user.
-- MAGIC   * **SQL Queries** (the icon will look like a command prompt): Allows you to add example SQL queries for Genie to learn from specific to the associated dataset(s).
-- MAGIC * **Monitoring** (the icon that looks like a eye): Allows you to review what questions were asked, who asked them, and how they were rated by the user. 
-- MAGIC * **Share** (the icon that looks like a lock): Allows you to set the share permissions and share the Genie space with end users. 
-- MAGIC
-- MAGIC Under the kebab menu, you'll find:
-- MAGIC * **Benchmarks** (the icon that looks like a graduate's mortarboard): Allows you to define a suite of questions that you run on a recurring basis to ensure the space continues to give good answers to the most important user questions.
-- MAGIC
-- MAGIC Additionally, you'll have the options to Clone and delete the Genie space by moving it to trash from this menu.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 3: Query the Genie space, and leave feedback
-- MAGIC
-- MAGIC Before we allow users into this Genie space, we need to try it out for ourselves. It may be that we need to refine its configuration before it gives helpful answers.
-- MAGIC
-- MAGIC 1. Return to the **Chats** area of the Genie space if you have navigated away.
-- MAGIC
-- MAGIC 1. Notice that our sample question about New South Wales customers is in a clickable button in the screen's right panel, and so is a sample question we didn't put in: "Explain the data set". Click on the **Explain the data set** button. Let's see how well Genie does in understanding our data with very little coaching.
-- MAGIC 1. How did Genie do? Did it figure out that the data sets are linked? Click on the thumbs-up icon below its response if it did, and click on thumbs-down if it didn't.
-- MAGIC 1. Now let's try the other sample question. Type in ```How many customers do we have in NSW?``` and click the paper-airplane icon to submit it.
-- MAGIC 1. Genie gives us a numerical answer. Do we trust it? Say _List them_ to compel Genie to show its work.
-- MAGIC 1. Was the numerical count of customers that Genie provided correct? If so, scroll back up to the "how many" question and give it a thumbs-up, and a thumbs-down if not.
-- MAGIC 1. Let's continue exploring Australia. Perth is a wonderful city, and Western Australia is amazing. Say ```How many customers do we have in WA?```
-- MAGIC 1. Does Genie know that WA in this context refers to Western Australia, and not, say, the American state of Washington? Ask Genie a trick question: ```How many customers do we have in Washington?``` Was its answer appropriate? If so, give it a thumbs-up, and a thumbs-down if not.
-- MAGIC 1. It's time for a more complex question. Say ```List the total amount of revenue from customers in Victoria by sales rep```. Did it do well? Again, give feedback.
-- MAGIC 1. If that previous question gave you an empty result, it is probably because Genie has forgotten to use Australian state abbreviations for the state field. Remind it: ```the data in the state field always represents Australian state abbreviations```
-- MAGIC
-- MAGIC     If you had this experience, you may notice that Genie corrects its previous answer. Scroll back up and click on **Add as instruction** so as to save this query as an example query. (Recall that you can only do this because you have at least edit rights on the Genie space. Your end users with only view rights can't add instructions.)
-- MAGIC
-- MAGIC
-- MAGIC 11. If Genie gave you a bar chart with that response, say "give me a pie chart of that" (and if it gave you a pie chart, ask instead for a bar chart). Which sales rep is the leader in Victoria?
-- MAGIC 1. Finally, let's ask Genie a question that has nothing to do with our company's data. Compose your own: try a trivia question about your favorite sports team, TV show, or musician. How does Genie respond?
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 4: View the feedback and act on it
-- MAGIC
-- MAGIC Regularly inspecting user feedback, and doing something about it, is the most important ongoing maintenance responsibility of a Genie space.
-- MAGIC
-- MAGIC 1. Navigate to the **History** area of the Genie space. Here you will see all the feedback you left so far. Notice that the **Rating** column reports the thumbs-ups and thumbs-downs you gave.
-- MAGIC
-- MAGIC 1. Choose a question to which you gave a thumbs-down and click on it. Genie shows you the question and the answer in context. Because Genie tries to repair earlier answers when it learns new things, you might need to scroll down in the chat context to see what the problem actually was. If you encountered a problem with Genie not knowing to use Australian state abbreviations, it'll become clear by reading the chat.
-- MAGIC 1. Let's try to make sure this doesn't happen to other people. Click on the **Instructions** tab at left (the icon that looks like a document) and type into the **General Instructions** box: ```The state field always uses Australian state abbreviations```. Type in anything else you may have learned that will improve Genie's performance. Click **Save**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 5: Publish the Genie space
-- MAGIC
-- MAGIC Users can't access a Genie space until you publish it. 
-- MAGIC
-- MAGIC 1. Click on the **Share** button at top right.
-- MAGIC
-- MAGIC 1. Choose the people who should be able to use this Genie space. For this activity, specify that all workspace users may use the space by clicking in the box for users, groups, or service principals, and choosing "All workspace users". Use the pulldown at right to assign **Can View** permission.
-- MAGIC 1. Click **Add**.
-- MAGIC 1. Click on the **Copy link** at bottom left to put the URL for this Genie space into your clipboard. In a real deployment, you would include this link in your announcement of the Genie space to its intended audience. In that communication, don't forget to emphasize how important it is that your users give feedback.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 6: Create a Genie Space from a Dashboard
-- MAGIC So far, we have been working with a standalone Genie space. Alternatively, you can create a Genie Space directly from a dashboard. Let's explore that choice.
-- MAGIC
-- MAGIC 1. Navigate to **Dashboards** in the main Databricks user interface and select the dashboard you created during **Module 01 - Dashboards and Visualizations in Databricks**. </p>
-- MAGIC 1. Switch to the **Draft** view for the dashboard. </p>
-- MAGIC 1. Select the kebab menu in the upper right corner, next to the **Share** option.</p>
-- MAGIC 1. Select **Open Draft Genie space**.
-- MAGIC 1. Ask the following question in the chatbox.
-- MAGIC
-- MAGIC     ```What tables are there and how are they connected? Give me a short summary.```
-- MAGIC 1. Review the response provided by Genie. 
-- MAGIC 1. Experiment with a few other questions, both those that ask for tabular or numeric information and those that ask for a visualization.
-- MAGIC
-- MAGIC This Draft Genie Space will not appear in the list of available Genie Spaces from the UI menu, but will be accessible from the Draft view of the associated Dashboard. In other words, it is not a separately manageable object. Users' access rights to it will always be the same as their access rights to the associated dashboard.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Challenge activity: Explore Opportunities
-- MAGIC
-- MAGIC If you have time, add more sample questions to the Genie space that relate to the **dbacademy.`YOURSCHEMA`.au_opportunities** table. What kinds of questions might your audience have about the differences among sales opportunities?

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
-- MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
-- MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
-- MAGIC <a href="https://help.databricks.com/">Support</a>