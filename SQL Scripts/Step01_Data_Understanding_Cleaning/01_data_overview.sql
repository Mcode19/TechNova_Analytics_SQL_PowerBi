                                                     ****Data Understanding & Cleaning****



01_data_overview
Purpose: Get an overview of row counts for each table in the sales schema.

1]

    Count how many customers are in the database
    SELECT COUNT(*) AS total_customers 
    FROM sales.customers;

-This query counts all rows in customers table & verify how many unique customers are in the dataset.


----------------------------------------------------------------------------------------------------------

2]

    Count how many products are available
    SELECT COUNT(*) AS total_products 
    FROM sales.products;

-This query counts all rows in products table & check the product catalog size.

----------------------------------------------------------------------------------------------------------

3]
   Count how many markets (regions) are defined
   SELECT COUNT(*) AS total_markets 
   FROM sales.markets;

-This query counts all rows in markets table & confirm regional coverage in dataset.

----------------------------------------------------------------------------------------------------------

4]
   Count how many transactions (sales records) exist
   SELECT COUNT(*) AS total_transactions 
   FROM sales.transactions;

-This query counts all rows in transactions table &  measure dataset size & workload.

----------------------------------------------------------------------------------------------------------

5]
   Count how many dates are in the calendar table
   SELECT COUNT(*) AS total_dates 
   FROM sales.date;

-This query counts all rows in date table & check completeness of time dimension.
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------


02_null_check.sql
Purpose: Verify if there are missing (NULL) values in important columns.


1]
    Customers table: Check for missing code
    SELECT COUNT(*) AS null_customer_code 
    FROM sales.customers 
    WHERE customer_code IS NULL;

-This query counts rows in customers where ID/code is missing & Ensures customer identity data is reliable.

----------------------------------------------------------------------------------------------------------

2]
   Customers table: Check for missing names/type
   SELECT COUNT(*) AS null_customer_name
   FROM sales.customers 
   WHERE customer_type IS NULL;

-This query counts rows in customers where names are blank & Confirms quality of customer dimension.

----------------------------------------------------------------------------------------------------------

3]
   Products table: Check for missing product code
   SELECT COUNT(*) AS null_product_id
   FROM sales.products 
   WHERE product_code IS NULL;

-This query checks for missing product identifier & Shows validate product master data.

----------------------------------------------------------------------------------------------------------

4]
   Products table: Check for missing product names
   SELECT COUNT(*) AS null_product_type 
   FROM sales.products 
   WHERE product_type IS NULL;

-This query checks for missing product names & Demonstrates look for descriptive completeness.

----------------------------------------------------------------------------------------------------------

5]
   Transactions table: Check for missing product links
   SELECT COUNT(*) AS null_product_code_in_txn 
   FROM sales.transactions 
   WHERE product_code IS NULL;

-Verifies that every transaction is linked to a product.

----------------------------------------------------------------------------------------------------------

6]
   Transactions table: Check for missing customer links
   SELECT COUNT(*) AS null_customer_code_in_txn 
   FROM sales.transactions 
   WHERE customer_code IS NULL;

-Ensures all transactions have valid customer reference.

----------------------------------------------------------------------------------------------------------

7]
   Transactions table: Check for missing currency
   SELECT COUNT(*) AS null_currency 
   FROM sales.transactions 
   WHERE currency IS NULL;

-Ensures all sales are recorded with a currency type.

----------------------------------------------------------------------------------------------------------

8] 
   Transactions table: Check for missing sales amount
   SELECT COUNT(*) AS null_sales_amount 
   FROM sales.transactions 
   WHERE sales_amount IS NULL;

-Checks for missing sales values which could skew KPIs.

----------------------------------------------------------------------------------------------------------

9]
   Date table: Check for missing date entries
   SELECT COUNT(*) AS null_date 
   FROM sales.date 
   WHERE date IS NULL;

-Validates that all time dimension entries are complete 
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------


03_duplicate_check.sql
Purpose: Find duplicate keys and repeated/identical rows across master and transaction tables.


1]
   Show column names for customers (helps you confirm which column to use)
   SHOW COLUMNS FROM sales.customers;

-This lists column names and types in customers table.
-Use  customer_code in the queries below.

----------------------------------------------------------------------------------------------------------

2]
   Show column names for products
   SHOW COLUMNS FROM sales.products;

-This lists column names and types in products table.

----------------------------------------------------------------------------------------------------------


3]  
   Show column names for transactions
   SHOW COLUMNS FROM sales.transactions;

-This lists column names and types in transactions table.

----------------------------------------------------------------------------------------------------------


4]
   SELECT customer_code, COUNT(*) AS cnt
   FROM sales.customers
   GROUP BY customer_code
   HAVING cnt > 1
   ORDER BY cnt DESC
   LIMIT 50;

-This finds customer_code values that appear more than once (possible duplicate keys).



5]
   SELECT customer_type, COUNT(*) AS cnt
   FROM sales.customers
   GROUP BY customer_type
   HAVING cnt > 1
   ORDER BY cnt DESC
   LIMIT 50;

-Helps find cases where the same type has multiple IDs (data quality issue).

 ----------------------------------------------------------------------------------------------------------


6]

   SELECT product_code, COUNT(*) AS cnt
   FROM sales.products
   GROUP BY product_code
   HAVING cnt > 1
   ORDER BY cnt DESC
   LIMIT 50;

-Finds repeated product identifiers.
----------------------------------------------------------------------------------------------------------


7]
  SELECT markets_code, COUNT(*) AS cnt
  FROM sales.markets
  GROUP BY markets_code
  HAVING cnt > 1
  ORDER BY cnt DESC
  LIMIT 50;

  SELECT markets_name, COUNT(*) AS cnt
  FROM sales.markets
  GROUP BY markets_name
  HAVING cnt > 1
  ORDER BY cnt DESC
  LIMIT 50;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


04_date_format_check.sql
Purpose: Verify date formatting and consistency across date master and transactions.


🔹SHOW COLUMNS FROM sales.date;
-Use the output to confirm the column name 

🔹 SHOW COLUMNS FROM sales.transactions;
-Use this to confirm if transaction date column is named 'order_date' or something else.


1]
  SELECT DISTINCT date
  FROM sales.date
  LIMIT 50;

-Shows sample date values from the calendar table so you can visually inspect formats.

 ----------------------------------------------------------------------------------------------------------

2]
 SELECT date
 FROM sales.date
 WHERE date IS NOT NULL
 AND date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 LIMIT 100;

-These rows don't match the YYYY-MM-DD pattern and need standardization or review & Ensures calendar table is clean for time series analysis.

 ----------------------------------------------------------------------------------------------------------

3]
  SELECT DISTINCT order_date
  FROM sales.transactions
  LIMIT 50;

-This helps see how transaction dates are stored (strings, datetime, date).

 ----------------------------------------------------------------------------------------------------------

4]
  SELECT order_date
  FROM sales.transactions
  WHERE order_date IS NOT NULL
  AND order_date NOT REGEXP ^[0-9]{4}-[0-9]{2}-[0-9]{2}$
 LIMIT 100;

-Find non-standard transaction date strings that may break time-based joins.

 ----------------------------------------------------------------------------------------------------------



5) If date columns are proper DATE/DATETIME types, check min/max for range sanity

SELECT MIN(date) AS min_calendar_date, MAX(date) AS max_calendar_date FROM sales.date;

SELECT MIN(order_date) AS min_txn_date, MAX(order_date) AS max_txn_date FROM sales.transactions;

-These checks ensure your time coverage is sane & Confirms date dimension and transaction time coverage are reliable for trend analysis.

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


05_basic_cleansing_examples.sql
Purpose: Demonstrate simple cleaning checks


1] 
  SELECT customer_name, TRIM(customer_name) AS cleaned_name
  FROM sales.customers
  LIMIT 10;
-Check for extra spaces in customer names

2]
 SELECT product_name, UPPER(product_name) AS standardized_name
 FROM sales.products
 LIMIT 10;
- Standardize product names to upper case

3] 
  SELECT DISTINCT markets_name, LOWER(markets_name) AS normalized_market
  FROM sales.markets
  ORDER BY markets_name;
- Ensure market names are consistent in lower case 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


06_date_and_currency_checks.sql
Purpose: Validate formats in date & currency fields

1] 
 SELECT order_date
 FROM sales.transactions
 WHERE order_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 LIMIT 20;
- Check if all order_date values are in proper YYYY-MM-DD format

2] 
  SELECT DISTINCT currency
  FROM sales.transactions;
- List distinct currencies used

3] 
  SELECT currency, COUNT(*) AS transaction_count
  FROM sales.transactions
  GROUP BY currency
  ORDER BY transaction_count DESC;
- Count how many transactions per currency


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 



























