                                                          ****Executive Summary****
 
Purpose: High-level KPIs for quick business understanding
 

1]  

SELECT ROUND(SUM(sales_amount),2) AS total_revenue
FROM sales.transactions;

- Total Revenue . Shows ability to quickly report total revenue.

----------------------------------------------------------------------------------------------------------


2] 

SELECT 
    (SELECT COUNT(DISTINCT customer_code) FROM sales.customers) AS total_customers,
    (SELECT COUNT(DISTINCT product_code) FROM sales.products) AS total_products,
    (SELECT COUNT(DISTINCT markets_code) FROM sales.markets) AS total_markets;

- Total Customers, Products, and Markets . Gives a one-shot overview of dataset size.

----------------------------------------------------------------------------------------------------------


 3] 

SELECT m.markets_name, SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.markets m ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY total_sales DESC
LIMIT 1;

- Best Performing Market .  Highlights strongest market.

----------------------------------------------------------------------------------------------------------


 4]

SELECT p.product_type, SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.products p ON t.product_code = p.product_code
GROUP BY p.product_type
ORDER BY total_sales DESC
LIMIT 1;

- Best Performing Product . Highlights top product category.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ 







