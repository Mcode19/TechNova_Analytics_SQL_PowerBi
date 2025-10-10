================================================================================================================================================
Step 5: Customer Analysis
File: step05_customer_analysis.sql
Purpose: Understand customer contribution to sales
================================================================================================================================================

🔹 Top 10 customers by sales amount

SELECT 
    c.custmer_name,
    SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.customers c 
    ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY total_sales DESC
LIMIT 10;

-Recruiter note: Shows ability to find most valuable customers.

================================================================================================================================================

🔹 Customer count by market (region)

SELECT 
    m.market_name,
    COUNT(DISTINCT c.customer_code) AS total_customers
FROM sales.customers c
JOIN sales.markets m 
    ON c.market_code = m.markets_code
GROUP BY m.market_name
ORDER BY total_customers DESC;

-Recruiter note: Helps identify where most customers are located.

================================================================================================================================================

🔹 Average sales per customer

SELECT 
    AVG(customer_total) AS avg_sales_per_customer
FROM (
    SELECT 
        c.customer_code,
        SUM(t.sales_amount) AS customer_total
    FROM sales.transactions t
    JOIN sales.customers c 
        ON t.customer_code = c.customer_code
    GROUP BY c.customer_code
) sub;

-Recruiter note: Shows analytical thinking — evaluating sales per customer.





