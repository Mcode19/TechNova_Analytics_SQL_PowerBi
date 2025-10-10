                                                           ****Total Sales by Market****


total_sales_by_market
Purpose: Understand overall revenue contribution by each market
 

1]

SELECT m.markets_name,

       SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.markets m
    ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY total_sales DESC;

- Identifies top-performing markets in terms of sales revenue.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    

                                                  ****Quantity Sold by Market****

quantity_by_market
Purpose: Check which markets have the highest sales volume
 
1]

SELECT m.markets_name,

       SUM(t.sales_qty) AS total_quantity
FROM sales.transactions t
JOIN sales.markets m
    ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY total_quantity DESC;

- Helps compare demand/volume across markets.


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    

                                                ****Currency Usage by Market****
currency_usage_by_market
Purpose: See which currencies are used in which markets
 
1]

SELECT m.markets_name,
       t.currency,
       COUNT(*) AS transaction_count,
       SUM(t.sales_amount) AS total_sales
FROM sales.transactions t
JOIN sales.markets m
    ON t.market_code = m.markets_code
GROUP BY m.markets_name, t.currency
ORDER BY total_sales DESC;

- Shows which markets depend on which currencies (important for global business insights).


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    


















