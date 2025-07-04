-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning">
-- MAGIC </div>
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 1.10 Lab - Dashboard and Visualization Lab Activity
-- MAGIC
-- MAGIC Databricks AI/BI Dashboards help you quickly transform data into shareable insights. 
-- MAGIC
-- MAGIC In this lesson, you will create a dashboard and make it useful by adding text, data, and interactive visualizations.
-- MAGIC
-- MAGIC This lesson uses the following resources:
-- MAGIC - Tables:
-- MAGIC   - Catalog: dbacademy
-- MAGIC   - Schema: {dynamically named, personal to you}
-- MAGIC   - Tables:
-- MAGIC     - au_customers
-- MAGIC     - au_orders
-- MAGIC     - au_products
-- MAGIC     - au_opportunities
-- MAGIC
-- MAGIC These tables contain simulated business-to-business order and opportunity data for an imaginary company's Australian sales operation. The **au_orders** table contains information from 2021 through the middle of November 2024, and the **au_opportunities** table contains the opportunities present in our company's Customer Relationship Management (CRM) software as of that time. Both of those tables identify the relevant customer with a unique key that points into the **au_customers** table, and both identify the relevant product with a unique key that points into the **au_products** table. You'll use the data in these tables to prepare your dashboard.
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

-- MAGIC %run "../Setup/au_setup"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC This script clones a few small data tables from a Databricks Marketplace share into your personal schema. At the end it prints out the name of your catalog and your schema. The schema will have a randomly generated name. Make a note of this value. In these instructions, we'll call this simply "your schema."
-- MAGIC
-- MAGIC To use the Catalog Explorer, follow the steps below.
-- MAGIC
-- MAGIC 1. Select **Catalog** from the sidebar navigation.
-- MAGIC 1. In the catalog selector, locate the catalog titled: **dbacademy**. You can also use the search at the top to narrow down the available options.
-- MAGIC 1. Expand your schema. You should see four tables in this schema.
-- MAGIC     - au_customers
-- MAGIC     - au_orders
-- MAGIC     - au_opportunities

-- COMMAND ----------

-- MAGIC %md
-- MAGIC %md
-- MAGIC ### Part 1: Data Discovery
-- MAGIC The first thing you'll need to complete any data analytics task is the appropriate data for the request. To find the right data, you'll need to use the Catalog Explorer or the Databricks Search to locate the data for this project.  In this particular lab exercise, a setup script will copy tables from a Databricks Marketplace share into a schema you control. To get started, click the small triangle Run button in the top left of the cell below.
-- MAGIC
-- MAGIC To use the Catalog Explorer, follow the steps below.
-- MAGIC
-- MAGIC 1. Select **Catalog** from the sidebar navigation.
-- MAGIC 1. In the catalog selector, locate the catalog titled: **dbacademy**. You can also use the search at the top to narrow down the available options.
-- MAGIC 1. Expand the {dynamically named, personal to you} schema. You should see three tables in this schema.
-- MAGIC     - au_customers
-- MAGIC     - au_orders
-- MAGIC     - au_opportunities
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC Now we have our data for this lesson.
-- MAGIC
-- MAGIC ---

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 2: Create a new Dashboard
-- MAGIC The first step in creating a new dashboard in Databricks is to decide upon the business purpose of the dashboard and its audience. For this dashboard, the business purpose will be to provide information on the performance of our Australia sales operation. The intended audience is any employee of our business who supports and evaluates our sellers.
-- MAGIC
-- MAGIC
-- MAGIC In the Databricks user interface, create a new, blank dashboard. 
-- MAGIC * Navigate to **Dashboards** in the side navigation pane.
-- MAGIC * Select **Create dashboard**. 
-- MAGIC * At the top of the resulting screen, click on the placeholder dashboard name ("New Dashboard" followed by a timestamp) and change it to **Australia Sales**.
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 3: Examine and Augment the Main Dataset
-- MAGIC
-- MAGIC With a completely new Dashboard, you need to associate the dashboard with data before you can begin designing the information display itself. At the top of the dashboard screen, you have two tabs, **Canvas** and **Data**. 
-- MAGIC
-- MAGIC - **Canvas:** The Canvas tab allows users to create visualizations and construct their dashboards. Each item on the canvas is called a widget. Widgets have three types: visualizations, text boxes, and filters.
-- MAGIC
-- MAGIC - **Data:** The **Data** tab allows you to define datasets that you will use in the dashboard. Datasets are bundled with dashboards when sharing, importing, or exporting them using the UI or API.
-- MAGIC
-- MAGIC You start off on the **Canvas** tab so that you can see the helpful overview that's provided. Select the **Data** tab to get started. 
-- MAGIC
-- MAGIC There are three small icons on the left side of the **Data** tab's screen area: **Datasets**, **Catalog**, and **Assistant**. 
-- MAGIC * **Datasets** (an icon depicting a list) will present you with a list of all the datasets used for the dashboard. This is where we start; it's empty now.
-- MAGIC * **Catalog** (the standard Databricks Catalog icon, three tiny shapes) allows you to navigate the available catalogs, schemas, and tables accessible to the workspace and select tables or materialized views to use as datasets.
-- MAGIC * **Assistant** (the standard Databricks Assistant icon, a tiny four-pointed star) provides you with a AI-powered interface for asking queries in natural language to the platform to discover objects or gain insights or assistance on query writing. 
-- MAGIC
-- MAGIC   **NOTE**: 
-- MAGIC   
-- MAGIC   - To make sure that subsequent instructions work literally, be sure that the field containing the customer's state is called **customer_state**. Of course you can always call it something else, but you'll need to adapt subsequent lab instructions. 
-- MAGIC
-- MAGIC   - Throughout these instructions, replace **`YOURSCHEMA`** with the name of your schema. (You can find your schema name in the setup run cell that you have just executed.)
-- MAGIC
-- MAGIC 1. With the **Datasets list** icon selected, click the **+ Create from SQL** button. Right-click the newly created query in the **Datasets** list and select **Rename**, or use the kebab menu, to rename the query as **orderhistory**.  
-- MAGIC 2. Let's borrow the SQL editor panel to look at the data in the **orders** and **au_customers** table. First, let's see what's in the **orders** table. Paste in this query:
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT * from dbacademy.YOURSCHEMA.au_orders LIMIT 10;
-- MAGIC ```
-- MAGIC
-- MAGIC   Then click the **Run** button. 
-- MAGIC
-- MAGIC   We see an order ID field, which is an integer; and next we see two ID fields consisting of incomprehensible strings, one field for the customer and one for the product. Next we see the date on which the order was placed, the quantity ordered, the total price of the order, and the name of the sales rep who managed the deal. It would be great if we could get more information about these customers and products, wouldn't it? For example, their names, and for the customers, where they are located. 
-- MAGIC
-- MAGIC 3. Fortunately, our schema contains a **au_customers** table. Use your mouse to clear the previous query from the SQL editor panel and paste this one in instead:
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT * from dbacademy.YOURSCHEMA.au_customers LIMIT 10;
-- MAGIC ```
-- MAGIC
-- MAGIC   Then click the **Run** button. 
-- MAGIC
-- MAGIC   We see an customer ID field, containing those same meaningless strings, but here for each we see the customer's name, their city, and their state (using standard Australian state abbreviations, which are either two or three letters). We should be able to use this table to look up information about our customers for our visualizations. For example, now we can report on all the customers who are in particular states.
-- MAGIC
-- MAGIC 4. But what about the products? There does not seem to be a similar table that explicates each product ID in the same way that **au_customers** does for the customer IDs. In the real world, it is very common to need to enhance and augment data to get good visualizations, and that is exactly what we are going to do. Fortunately, in this example company, there are only 9 products, so we can quickly create a small table with more information about each.  _In this screen_, not in the Databricks user interface, click the small "Play" icon (the rightward-pointing triangle) at the top of the code block immediately below these words.

-- COMMAND ----------

-- Remember, don't paste this cell into the Dashboards SQL editor panel.
-- Just click the small "Run" triangle in this box's top left corner
DROP TABLE IF EXISTS dbacademy.YOURSCHEMA.au_products;

CREATE TABLE dbacademy.YOURSCHEMA.au_products (productid string, productname string, listprice float);

INSERT INTO
  dbacademy.YOURSCHEMA.au_products (productid, productname, listprice)
VALUES
  ('JQ9322', 'TableSaw', 24.99),
  ('A802a', 'Mill', 10.17),
  ('EE05x', 'Press', 363.02),
  ('R9S10', 'Lathe', 43.83),
  ('BC111d', 'Drill', 63.28),
  ('W8931', 'Planer', 45.22),
  ('Q28R3', 'Grinder', 176.33),
  ('MDb304', 'CAD System', 502.80),
  ('OR307p', 'Kazoo', 0.99);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 6. Now return to the Databricks user interface window. Return to the SQL editor panel in the Dashboards dataset definition screen. Use your mouse to clear the previous query from the SQL editor panel and paste this one in instead:
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT * from dbacademy.YOURSCHEMA.au_products;
-- MAGIC ```
-- MAGIC Then click the **Run** button. 
-- MAGIC
-- MAGIC Now we have a table called **au_products** with human-friendly information about each product.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 4: Define the Main Dataset
-- MAGIC
-- MAGIC Now we have enhanced our schema with useful information for our dashboard's audience, who cannot be expected to recognize those arbitrary product IDs. In the real world, you would be more likely to enhance your data by _uploading_ the data for a new table, such as a Comma-Separated Value file ("CSV file"). These CSV files are commonly created through exporting spreadsheets. Instead, we created a table using Databricks SQL. Nevertheless, we are finally ready to create a table with everything we need to help our dashboard's end users.
-- MAGIC
-- MAGIC 1. Be sure that you are in the Databricks user interface window, and in its Dashboards dataset definition screen. The **orderhistory** dataset should be selected. Use your mouse to clear any previous query from the SQL editor panel. 
-- MAGIC 1. Now click the Assistant icon at left. 
-- MAGIC 1. In the Assistant chat box, describe the SQL query you need. 
-- MAGIC  Specifically: 
-- MAGIC  
-- MAGIC     You want a query that returns all the fields in **dbacademy.YOURSCHEMA.au_orders**, plus the customername, city, and state fields from **dbacademy.YOURSCHEMA.au_customers**, joining those two tables on the **customerid** field. You also want to pull in the **productname** field from **dbacademy.YOURSCHEMA.au_products**, joining those two tables on the **product** field. The customer's state should be called **customer_state**.
-- MAGIC
-- MAGIC      Feel free to use the above query description or rewrite it in your own words.
-- MAGIC
-- MAGIC  ---
-- MAGIC **TIPS FOR SUCCESS**
-- MAGIC
-- MAGIC * You don't have to get the Databricks Assistant to produce the perfect SQL query. Use it to get  close to the goal, and then touch up the final query as needed. 
-- MAGIC
-- MAGIC * In the context of defining a dashboard, always name tables with their full three-part form: _catalog_._schema_._table_. 
-- MAGIC
-- MAGIC * Sometimes Databricks Assistant guesses wrong about the exact name of the field that binds two tables together. You can tell it explicitly what field to join on, as we did in our query description above. Or your data engineers can help Databricks Assistant in a more permanent way by defining the underlying tables to have a [constraint clause](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-table-constraint.html). 
-- MAGIC
-- MAGIC ---
-- MAGIC
-- MAGIC  Feel free to use the above query description or rewrite it in your own words. 
-- MAGIC 1. Copy the SQL query that Assistant suggests and paste it into the SQL editor panel in the center of the screen (over the words "Start typing...").
-- MAGIC 1. Run your query and see if it works! You may need to adjust it. If there is an error, Assistant will display a "Diagnose error" button to inspect your SQL and offer a corrected query. Copy the new query back into the SQL editor panel, overwriting the previous attempt, and try to run it again. You might need to use the "Diagnose error" button more than once.
-- MAGIC
-- MAGIC     If you get stuck, a sample query you can use is at the end of this lab exercise. 
-- MAGIC
-- MAGIC 6. When your dataset looks satisfactory, Right-click the newly created query in the **Datasets** list and select **Rename**, or use the kebab menu, to rename the query as **orderhistory**. 
-- MAGIC 1. If you like, you can close the Assistant window by clicking the X at top right. But you can always return to it, with full history, by clicking the Assistant icon.
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 5: Add a Dataset for the 2024 Sales Goal
-- MAGIC
-- MAGIC 1. Still in the **Data** tab, select the **+ Create from SQL** option. 
-- MAGIC 2. Enter the following query into the query editing space:
-- MAGIC ```
-- MAGIC   SELECT 
-- MAGIC       sum(orderamt) AS Total_Sales, 390000000 AS Sales_Goal 
-- MAGIC   FROM 
-- MAGIC       dbacademy.YOURSCHEMA.au_orders
-- MAGIC   WHERE 
-- MAGIC       orderdate >= '2024-01-01' AND orderdate <= '2024-12-31' ;
-- MAGIC
-- MAGIC ```
-- MAGIC 3. Click **Run** to execute the query. 
-- MAGIC 4. Right-click the newly created query in the **Datasets** list and select **Rename**, or use the kebab menu, to rename the dataset it constitutes as **SumTotalSales**.
-- MAGIC
-- MAGIC Now your dashboard has a total of two datasets.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Part 6: Add Visualizations

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Adding a Text Box
-- MAGIC
-- MAGIC Let's add a name and a space for a text description of the dashboard to the canvas. When adding a new widget to the canvas, other widgets automatically move to accommodate your placement. You can use your mouse to move and resize widgets. To delete a widget, right-click it and choose **Delete** from the resulting context menu. 
-- MAGIC
-- MAGIC Complete the following steps to add a text box to the dashboard:
-- MAGIC
-- MAGIC 1. Click on the **Canvas** tab at top right to switch to the canvas view.
-- MAGIC 1. At the bottom of the screen you have a palette for adding various widgets. Click the icon in the palette for adding a text box and drag the resulting widget to the top of your canvas. The text-box icon looks like a T in a small rectangle.
-- MAGIC 1. Click into the just-placed widget and type: `# Australia Sales`
-- MAGIC
-- MAGIC     **Note:** Text boxes use [Markdown](https://daringfireball.net/projects/markdown/syntax) syntax. The single `#` character in the included texts indicates that <b>Australia Sales</b> is to be styled as a level-1 heading. 
-- MAGIC
-- MAGIC 1. On the next line, type a brief explanation of what this dashboard is for, such as "This dashboard helps you support and evaluate our Australia sales operation". Append an invitation for users to email you with feedback using Markdown's embedded-link syntax:
-- MAGIC
-- MAGIC    `[Send me feedback!](mailto:your@email.address)`
-- MAGIC
-- MAGIC
-- MAGIC 1. Now open up a new line above the Australia Sales header. Here you will add a company logo. First type the Markdown syntax for an embedded image:
-- MAGIC
-- MAGIC     `![company logo]()` 
-- MAGIC
-- MAGIC     (Whatever is between the square brackets will be treated as alt text.)
-- MAGIC     
-- MAGIC     Now get an image URL into your browser's clipboard. You can right-click on the image below and capture its link address to use it, or you can use another logo, such as your own company's. Just make sure that the image is small. (Pro-tip: open the image in a new browser tab to confirm that it is small before proceeding.)
-- MAGIC
-- MAGIC     ![newlogo4_sm](files/images/ai-bi-for-data-analysts-1.1.0/newlogo4_sm.png)
-- MAGIC
-- MAGIC     Paste the URL between the parentheses (not the brackets!). 
-- MAGIC
-- MAGIC
-- MAGIC 1. Drag the right edge of the text widget inward so that it is about 1/2 the width of the dashboard. You are making room for a widget to sit to the right of the title. Adjust the bottom edge as needed so that all the contents of the text box are visible.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Adding a Counter
-- MAGIC
-- MAGIC The first visualization we'll be adding to the dashboard is a counter visualization to display the current sales against a sales goal of $390 million.
-- MAGIC
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a visualization, which is a tiny thumbnail of a line chart.  
-- MAGIC 1. Move your cursor to anywhere on the screen and click to add the visualization to the canvas.  
-- MAGIC 1. In the configuration panel on the right, make the following selections for the settings:
-- MAGIC     - **Dataset:** **SumTotalSales**
-- MAGIC     - **Visualization:** Counter
-- MAGIC     - **Title:** Checked
-- MAGIC       - Click on **Widget Title** on the visualization.
-- MAGIC       - Change it by typing over it to **Sales Goal**.
-- MAGIC     - **Value:** Total_Sales
-- MAGIC     - **Target:** Sales_Goal
-- MAGIC
-- MAGIC 1. Click on **Total_Sales** in the **Value** area of the configuration panel and select **Format** from the resulting dropdown. Make the following adjustments:
-- MAGIC     - Change **Auto** to **Custom**.
-- MAGIC     - Set **Type** to Currency ($)
-- MAGIC     - Change the Currency to Australian Dollars ($)
-- MAGIC
-- MAGIC 1. In the Style section, click the **+** next to **Conditional Style**. Configure it with the following settings:
-- MAGIC     - If Value <= Target
-- MAGIC     - Then (Color: Red)
-- MAGIC
-- MAGIC Adjust the width of the counter visualization so that it is 1/2 the width of the dashboard, then drag the edges or click-hold while hovering over the visualization box to put it to the right of the title box. Adjust the height of the counter visualization so that it is 1/2 the height of the adjacent text box. 
-- MAGIC
-- MAGIC Try this experiment: change the currency of the sales total to British Pounds (£). Does the value displayed change, or just the currency symbol? Change the currency back to Australian Dollars ($) before proceeding.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC #### Adding a combo chart
-- MAGIC Next, let's add another visualization, this time a Combo Chart containing information about total sale price and count of sales over a three months span.
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a visualization.
-- MAGIC 1. Land the new widget on the left side of the canvas underneath the text box. Click in the new widget to give it focus. 
-- MAGIC 1. In the **Configuration Panel** on the right, make the following selections for the settings:
-- MAGIC     - **Dataset**: **orderhistory**
-- MAGIC     - **Title:** Checked
-- MAGIC       - Click on **Widget Title** on the visualization.
-- MAGIC       - Change it by typing over it to **Order History**.
-- MAGIC     - **Visualization**: Combo
-- MAGIC     - **X axis**: Click the **+** and select **orderdate**.
-- MAGIC       Notice that the dialogue guesses that we want to view the data on a monthly basis by replacing **orderdate** with **MONTHLY(orderdate)**.
-- MAGIC
-- MAGIC         Click on **MONTHLY(orderdate)** and fill in **Order date** for the **Display name**.
-- MAGIC     - In the **Y axis** section:
-- MAGIC       - **Bar**: Click the **+** and select **orderamt**.
-- MAGIC       Notice that the dialogue guesses that we want to sum the order amounts by replacing **orderamt** with **SUM(orderamt)**. It also automatically knows that these sums should be on a monthly basis, because that is the grouping selected for the X axis.
-- MAGIC
-- MAGIC         Click on **SUM(orderamt)** and fill in Total Sales Value for the **Display name**.
-- MAGIC       - **Line**: Total_Sales
-- MAGIC         Change **Right Y axis (Line)** to **COUNT(*)** (which is offered at the end of the list of fields; this is SQL syntax for "count the number of records")
-- MAGIC                 
-- MAGIC           Click on **COUNT(*)** and fill in Count of Sales Orders for the **Display name**.
-- MAGIC
-- MAGIC 1. So far this doesn't look very useful, does it? The line for **Count of Sales Orders** hugs the X axis because the Y axis covers values in the millions (of dollars). Let's fix this. Select the kebab menu icon next to **Y axis** and click **Enable dual axis**. Enabling dual axis allows us to see changes in the data on two different scales. 
-- MAGIC
-- MAGIC   You can also adjust the colors for the series by selecting the color blocks next to series names.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC #### Adding a bar chart using Databricks Assistant
-- MAGIC
-- MAGIC When drafting a dashboard, you can provide a natural language prompt to the Databricks Assistant and it autogenerates a chart based on your request. The Databricks Assistant can help you build charts based on any dataset defined in your dashboard's data tab. Let's try it out.
-- MAGIC
-- MAGIC Complete the following steps:
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a visualization.
-- MAGIC 1. Land the new widget on the left side of the canvas underneath the text box. Click in the new widget to give it focus.
-- MAGIC 1. In the "Ask the Assistant to create a chart..." box at the top of your new widget, enter the following prompt:  
-- MAGIC
-- MAGIC     _Create a bar chart from the orderhistory dataset with productname on the x-axis and orderamt on the y-axis_
-- MAGIC
-- MAGIC 1. Click the paper-airplane icon to generate a response. It may take a moment for the Assistant to provide a visualization.  
-- MAGIC 1. You will get a bar chart that matches the provided description. Click <b>Accept</b> to confirm the visualization meets your needs.  
-- MAGIC
-- MAGIC     If the visualization does not match your description or match the kind of visualization you wanted to create, you can reject or regenerate the response. You can also adjust the configuration of the chart once accepted. 
-- MAGIC   
-- MAGIC 1. Change the color of the chart to something other than the default. Use the configuration panel's **Color** section.
-- MAGIC 1. Check the **Title** box in the configuration panel. Then click on the placeholder widget title on the visualization. Change it by typing over it to **Average Order Amount per Product**.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Adding a pie chart
-- MAGIC
-- MAGIC Let's show how our revenue is distributed among the Australian states by adding a pie chart. To make this pie chart, complete the following steps:
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a visualization.
-- MAGIC 1. Land the new widget on the left side of the canvas underneath the text box. Click in the new widget to give it focus.  
-- MAGIC 1. In the **Configuration Panel** on the right, make the following selections for the settings: 
-- MAGIC
-- MAGIC     - **Dataset**: **orderhistory**
-- MAGIC     - **Title:** Checked
-- MAGIC       - Click on the placeholder widget title on the visualization.
-- MAGIC       - Change it by typing over it to **Revenue Share by State**.
-- MAGIC     - **Visualization**: Pie
-- MAGIC     - **Angle**: **orderdate**
-- MAGIC
-- MAGIC       Click on **orderdate** and fill in **Revenue** for the display name.
-- MAGIC     - **Color**: Click the **+** and choose **customer_state**.
-- MAGIC       Click on **customer_state** and fill in **State** for the display name.
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Adding a heatmap
-- MAGIC
-- MAGIC Let's examine how our order totals vary across Australia both by the state and also by the sales rep who executed the order.
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a visualization.
-- MAGIC 1. Land the new widget on the left side of the canvas underneath the text box. Click in the new widget to give it focus.  
-- MAGIC 1. In the **Configuration Panel** on the right, make the following selections for the settings: 
-- MAGIC
-- MAGIC     - **Dataset**: **orderhistory**
-- MAGIC     - **Title:** Checked
-- MAGIC       - Click on the placeholder widget title on the visualization.
-- MAGIC       - Change it by typing over it to **Distribution of Order Quantity across States and Sales Reps**.
-- MAGIC     - **Visualization**: Heatmap
-- MAGIC     - **X axis**: **salesrep**
-- MAGIC
-- MAGIC       Click on **salesrep** and fill in **Rep** for the display name.
-- MAGIC     - **Y axis**: Click the **+** and choose **customer_state**.
-- MAGIC       Click on **customer_state** and fill in **State** for the display name.
-- MAGIC     - **Color**: Click the **+** and choose **quantity**.
-- MAGIC       Click on **SUM(quantity)** and fill in **Qty** for the display name.
-- MAGIC
-- MAGIC       Click on the little color swatch and choose a more fun color ramp than the default.
-- MAGIC
-- MAGIC Which sales rep probably has Sydney in their territory?
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC ### Cross-filtering, and adding filter widgets
-- MAGIC
-- MAGIC Databricks AI/BI Dashboards offer user interactivity even if you, the dashboard author, don't do any extra work. To see this, hover over the Order History bar chart's bars. A tooltip pops up for each sales-value bar giving its exact value, as well as the sales-count line's value for that month.
-- MAGIC
-- MAGIC That's not all. Try clicking on one of the boxes in the heatmap. Notice that all the other visualizations adjust to focus on that sales rep and that state. To undo that adjustment, click again on the same box you clicked on. Now try clicking on the segments of the pie chart. This feature, called cross-filtering, lets your users get more information out of your dashboards with no extra work on your part and no need for them to ask you for help. (Again, to undo the adjustment, click once more on the pie-chart segment you clicked on.)
-- MAGIC
-- MAGIC But what if a user wants to refine an entire visualization in a more complex or precise way? Maybe they want to hone in, say, a time-range or a product or a sales rep of interest. Filters are widgets that allow dashboard viewers to do just that. All you have to do is to build the appropriate widget into your dashboard, and AI/BI Dashboards does the rest.
-- MAGIC
-- MAGIC Filters automatically apply to all the visualizations on the same page that share their dataset. That means that the more distinct datasets your dashboard is built on, the more filter widgets you might have to offer, and the more you'll have to help users understand which filters work with which visualizations. It is wise to be economical with the number of datasets in a dashboard.
-- MAGIC
-- MAGIC To add a filter on orders across a user's preferred date range to the dashboard, complete the following steps:
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a filter, which looks like a tiny funnel.
-- MAGIC 1. Land the new widget wherever it is convenient for now. Click in the new widget to give it focus.
-- MAGIC 1. When the filter widget is selected, the filter configuration panel appears on the right side of the screen.
-- MAGIC   
-- MAGIC 1. Apply the following settings:  
-- MAGIC   - **Filter**: Date range picker
-- MAGIC   - **Fields**: Expand the **orderhistory** dataset and choose **orderdate**
-- MAGIC 6. Use the checkboxes to turn on **Title**.  
-- MAGIC 1. Click the placeholder title on the new filter widget and change it to **Order Date**  
-- MAGIC
-- MAGIC Let's add another one! To add a selection filter for products to the dashboard, complete the following steps:
-- MAGIC
-- MAGIC 8. Return to the **Canvas** tab if you navigated away.  
-- MAGIC 1. Click the icon in the palette for adding a filter.
-- MAGIC 1. Land the new widget wherever it is convenient for now. Click in the new widget to give it focus.
-- MAGIC 1. When the filter widget is selected, the filter configuration panel appears on the right side of the screen.
-- MAGIC   
-- MAGIC 1. Apply the following settings:  
-- MAGIC   - **Filter**: Multiple values
-- MAGIC   - **Fields**: Expand the **orderhistory** dataset and choose **productid**
-- MAGIC 13. Use the checkboxes to turn on **Title**.  
-- MAGIC 1. Click the placeholder title on the new filter widget and change it to **Product**  
-- MAGIC
-- MAGIC 1. Experiment with your filter. Notice that both the graph-style visualizations you have added so far respond to the date ranges you supply, while the **Sales Goal** counter widget does not. Why not? Did we make a good decision when we used a separate dataset to define **Sales Goal**? (Hint: our organization has established a sales goal that goes across the entire year and across all products.)
-- MAGIC 1. To clear the date filter and return to a display of all the data, click the tiny calendar icon at the right edge of the filter box and choose **All** from the resulting pulldown.
-- MAGIC 1. Move the two filter widgets you created into the empty space underneath the sales-goal counter widget. Now they are at the top of the dashboard, a very visually prominent location that will remind users when a filter is active.
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC The image below is supplied as an example of how your dashboard's first page could appear once you've finished adding visualizations and customizing the colors and features of the dashboard. The lab activity continues below the image.
-- MAGIC
-- MAGIC ![australia_sales_dashboard_lab_solution](files/images/ai-bi-for-data-analysts-1.1.0/australia_sales_dashboard_lab_solution.png)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Adding another page to the dashboard
-- MAGIC
-- MAGIC Sometimes it is helpful to let people browse the underlying data. Let's give that opportunity, but put it on a separate page, so as not to clutter up the main page. 
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC
-- MAGIC 1. Because we are now going to have two pages, let's rename the first one to something helpful. Click the kebab menu next to **Untitled page**, choose **Rename**, and specify a new name of **Visualizations**.
-- MAGIC
-- MAGIC 1. Now click the `+` icon to the right of **Visualizations** to add a new page. Click the kebab menu next to the newly created **Untitled page**, choose **Rename**, and specify a new name of **Browse data**.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Adding a table widget to the dashboard's second page
-- MAGIC
-- MAGIC Now that we have a separate page, we can let people browse the underlying data if they wish without cluttering our handsome graphs.
-- MAGIC
-- MAGIC 1. Return to the **Canvas** tab if you navigated away.  
-- MAGIC
-- MAGIC 1. If you are not already viewing the page called **Browse data** click on its button at top left to move to it.
-- MAGIC
-- MAGIC 1. Select **Add a visualization** from the menu at the bottom of the canvas and click on the canvas to add the visualization. 
-- MAGIC
-- MAGIC 1. In the **Configuration Panel** on the right, make the following selections for the settings: 
-- MAGIC
-- MAGIC     - **Dataset**: **orderhistory**
-- MAGIC     - **Visualization**: Table
-- MAGIC     - **Columns**: 
-- MAGIC       - Click the box for **Show/hide all** to add all the fields to the table.
-- MAGIC       - Click the eye icon next to the **orderid**, **customerid**, and **productid** fields to hide them.
-- MAGIC
-- MAGIC 1. Grab the right edge of the widget and expand it to the full width of the page.
-- MAGIC
-- MAGIC Notice that, just as with a spreadsheet, your users can sort all the data by clicking on the header. Clicking once selects ascending order and clicking again selects descending order.
-- MAGIC
-- MAGIC Does the date selection widget on the front page of the dashboard affect this table?
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC ### Part 7: Securely share your dashboard
-- MAGIC
-- MAGIC When your dashboard is complete, to share it with others, you need to publish it. 
-- MAGIC
-- MAGIC Published dashboards can be shared with other named users in your workspace. You can also share them with users registered at the account level: that is, users registered to your Databricks account who may not have been assigned any specific Databricks resources. Frequently leaders and line-of-business workers are in this category. This capability helps you deliver data insights to people who are not data professionals. 
-- MAGIC
-- MAGIC When you publish a dashboard, the default setting is to **embed credentials**. Embedding credentials in your published dashboard allows dashboard viewers to **use your credentials to access the data and power the queries that support it**. If you choose not to embed credentials, dashboard viewers use their own credentials to access necessary data and compute power. If a viewer does not have access to the default SQL warehouse that powers the dashboard, or if they do not have access to the underlying data, _visualizations will not render._
-- MAGIC
-- MAGIC To publish your dashboard, complete the following steps:
-- MAGIC
-- MAGIC 1. Click <b>Publish</b> in the upper-right corner of your dashboard. Read the setting and notes in the <b>Publish</b> dialog. </p>
-- MAGIC 2. Click <b>Publish</b> in the lower-right corner of the dialog. The <b>Sharing</b> dialog should open afterward. If it does not open, you can select **Share** next to **Publish** at the top of the dashboard.
-- MAGIC     - You can use the text field to search for individual users, or share the dashboard with a preconfigured group, like <b>Admins</b> or <b>All workspace users</b>. From this window, you can grant leveled privileges like <b>Can Manage</b> or <b>Can Edit</b>. See <a href="https://docs.databricks.com/en/security/auth-authz/access-control/index.html#lakeview" target="_blank">Dashboard ACLs</a> for details on permissions.
-- MAGIC     - The bottom of the <b>Sharing</b> dialog controls view access. Use this setting to easily share with all account users.
-- MAGIC 3. <p style="color: #0873FF"> Under <b>Sharing settings</b>, choose <b>Anyone in my account can view</b> from the drop-down. Then, close the <b>Sharing</b> dialog. </p>
-- MAGIC 4. <p style="color: #0873FF"> Use the drop-down near the top of the dashboard to switch between <b>Draft</b> and <b>Published</b> versions of your dashboard. </p>
-- MAGIC
-- MAGIC **Note:** When you edit your draft dashboard, viewers of the published dashboards do not see your changes until you republish. The published dashboard includes visualizations that are built on queries that can be refreshed as new data arrives. When dashboards are refreshed, they updated with new data automatically; the dashboards do not need to be republished.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Part 8: Establish a refresh schedule
-- MAGIC
-- MAGIC A refresh schedule helps you optimize the performance of  dashboards built on datasets that grow and change. You can schedule a regular refresh of the data in your dashboard, thus ensuring that Databricks' cache of data is up-to-date. The refresh schedule dialogue is also where you can manage users' subscriptions to your dashboard. Subscribed users get an email at every refresh with a snapshot image of the first page of the dashboard, as well as a link back to the live dashboard in Databricks.
-- MAGIC
-- MAGIC 1. Navigate to the published view of your dashboard if you are not already there. The **Draft**/**Published** pulldown at top should show a green circle.
-- MAGIC 1. Click the **Schedule** button.
-- MAGIC 1. Use the user interface to establish a daily refresh schedule. Choose a time that is in a few minutes.
-- MAGIC 1. Click to save the schedule.
-- MAGIC 1. Click the **Schedule** button again. You will notice that the **Subscribers** tab is no longer grayed out. Click it.
-- MAGIC 1. You will notice that there is one refresh schedule now in place for this dashboard, with a **Subscribe** box next to it. Click it.
-- MAGIC
-- MAGIC   In a production Databricks instance you would use this user interface to manage the subscribers to your dashboard. As a security measure, you cannot subscribe arbitrary email addresses to your dashboard. Only users with a Databricks account in this Databricks workspace can subscribe.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC ### Appendix: Sample SQL Query
-- MAGIC
-- MAGIC Here is a query you can use to define the dashboard's main **orderhistory** dataset.
-- MAGIC
-- MAGIC ```
-- MAGIC SELECT
-- MAGIC     o.*,
-- MAGIC     c.customername AS customername,
-- MAGIC     c.state AS customer_state,
-- MAGIC     p.productname AS productname
-- MAGIC FROM 
-- MAGIC     dbacademy.YOURSCHEMA.au_orders AS o
-- MAGIC JOIN 
-- MAGIC     dbacademy.YOURSCHEMA.au_customers AS c
-- MAGIC     ON o.customerid = c.customerid
-- MAGIC JOIN 
-- MAGIC     dbacademy.YOURSCHEMA.au_products AS p
-- MAGIC     ON o.productid = p.productid ;
-- MAGIC ```
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ---
-- MAGIC ### Challenge activity: Opportunities page
-- MAGIC
-- MAGIC If you have time, enhance your dashboard by adding a third page and presenting helpful visualizations of the opportunities table. To do so, you'll need to define a new dataset that joins the **opportunities** table to the **au_customers** table and then explore the data in the table. What fields are present? What visualizations might be interesting? Consider visualizations that compare the opportunities by sales phase and by sales rep.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC &copy; 2025 Databricks, Inc. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the 
-- MAGIC <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC <br/><a href="https://databricks.com/privacy-policy">Privacy Policy</a> | 
-- MAGIC <a href="https://databricks.com/terms-of-use">Terms of Use</a> | 
-- MAGIC <a href="https://help.databricks.com/">Support</a>