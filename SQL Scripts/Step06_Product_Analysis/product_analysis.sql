 
                                                     ****Product Analysis****


06_product_analysis 
Purpose: Identify product performance and contribution
 

1]

SELECT 
    p.product_code,
    SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.products p 
    ON t.product_code = p.product_code
GROUP BY p.product_code
ORDER BY total_sales DESC

LIMIT 10;

- Highlights which products generate the highest revenue.Top 10 best-selling products by sales amount

================================================================================================================================================

2]  

SELECT 
    p.product_name,
    SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.products p 
    ON t.product_code = p.product_code
GROUP BY p.product_name
ORDER BY total_sales ASC
LIMIT 10;

-  Identifies weak-performing products.Products with lowest sales


================================================================================================================================================

3]

SELECT 
    (SUM(top_products.total_sales) / (SELECT SUM(sales_amount) FROM sales.transactions)) * 100 
    AS contribution_percentage
FROM (
    SELECT 
        p.product_name,
        SUM(t.sales_amount) AS total_sales
    FROM sales.transactions t
    JOIN sales.products p 
        ON t.product_code = p.product_code
    GROUP BY p.product_name
    ORDER BY total_sales DESC
    LIMIT 10
) AS top_products;

- Contribution of top 10 products to total sales Demonstrates ability to calculate contribution % of top products.


