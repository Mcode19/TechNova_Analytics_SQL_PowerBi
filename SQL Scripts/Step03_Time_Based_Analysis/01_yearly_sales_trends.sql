                                                        ****Yearly Sales Trends****


01_yearly_sales_trends.sql
Purpose: Analyze sales performance year by year

1]Total sales per year

SELECT d.year, SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.date d 
    ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;

- Total sales per year & Identifies how sales evolved over years.

 ----------------------------------------------------------------------------------------------------------

2] 

SELECT d.year, SUM(t.sales_qty) AS total_quantity
FROM sales.transactions t
JOIN sales.date d 
    ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;

- Total quantity sold per year & Shows growth in physical volume, not just revenue.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 


