
Step 2: Basic Descriptive Analysis
File: step02_basic_descriptive_analysis.sql
Purpose: Count entities, summarize sales, and check currency distribution
================================================================================================================================================

🔹 Total number of customers

SELECT COUNT(DISTINCT customer_code) AS total_customers
FROM sales.customers;

-Recruiter note: Ensures understanding of dataset size (customer base).

================================================================================================================================================

🔹 Total number of products

SELECT COUNT(DISTINCT product_code) AS total_products
FROM sales.products;

-Recruiter note: Shows awareness of product catalog size.

================================================================================================================================================

🔹 Total number of markets

SELECT COUNT(DISTINCT markets_code) AS total_markets
FROM sales.markets;

-Recruiter note: Confirms dataset’s regional spread.

================================================================================================================================================

🔹 Total sales amount

SELECT SUM(sales_amount) AS total_sales
FROM sales.transactions;

-Recruiter note: Shows ability to compute overall revenue.

================================================================================================================================================
🔹 Total quantity sold

SELECT SUM(sales_qty) AS total_quantity
FROM sales.transactions;

-Recruiter note: Demonstrates aggregation of operational KPIs.

================================================================================================================================================

🔹 Total number of transactions

SELECT COUNT(*) AS total_transactions
FROM sales.transactions;

-Recruiter note: Verifies sales volume scale.

================================================================================================================================================

🔹 Count transactions by currency type

SELECT currency, COUNT(*) AS transaction_count
FROM sales.transactions
GROUP BY currency
ORDER BY transaction_count DESC;

-Recruiter note: Identifies share of sales records per currency.

================================================================================================================================================

🔹 Total sales amount by currency

SELECT currency, SUM(sales_amount) AS total_sales
FROM sales.transactions
GROUP BY currency
ORDER BY total_sales DESC;

-Recruiter note: Helps evaluate relative importance of currencies.





