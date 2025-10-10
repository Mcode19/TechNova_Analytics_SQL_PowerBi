================================================================================================================================================
Step 7: Currency Insights
File: step07_currency_insights.sql
Purpose: Analyze sales behavior across different currencies
================================================================================================================================================
🔹 Count transactions by currency

SELECT 
    currency,
    COUNT(*) AS transaction_count
FROM sales.transactions
GROUP BY currency
ORDER BY transaction_count DESC;

-Recruiter note: Shows distribution of records across currencies.

================================================================================================================================================

🔹 Total sales amount by currency

SELECT 
    currency,
    SUM(sales_amount) AS total_sales
FROM sales.transactions
GROUP BY currency
ORDER BY total_sales DESC;

-Recruiter note: Identifies revenue contribution of each currency.

================================================================================================================================================

🔹 Average sales amount per transaction by currency

SELECT 
    currency,
    AVG(sales_amount) AS avg_sales
FROM sales.transactions
GROUP BY currency
ORDER BY avg_sales DESC;

-Recruiter note: Highlights differences in average deal size across currencies.


