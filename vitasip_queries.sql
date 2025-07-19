
-- Check for missing Total_Sale entries
SELECT * FROM sales_data
WHERE "Total_Sale" IS NULL OR TRIM("Total_Sale") = '';

-- Check for missing Channel entries
SELECT * FROM sales_data
WHERE Channel IS NULL OR TRIM(Channel) = '';

-- Check for missing Customer_Type entries
SELECT * FROM sales_data
WHERE Customer_Type IS NULL OR TRIM(Customer_Type) = '';

-- Check for missing Product entries
SELECT * FROM sales_data
WHERE Product IS NULL OR TRIM(Product) = '';

-- Get min/max Quantity and Total_Sale values
SELECT 
  MIN(Quantity), MAX(Quantity), 
  MIN("Total_Sale"), MAX("Total_Sale")
FROM sales_data;

-- Check table structure
PRAGMA table_info(sales_data);

-- Total sales by date (first 10)
SELECT Date_of_Sale, SUM(Total_Sale) AS daily_sales
FROM sales_data
GROUP BY Date_of_Sale
ORDER BY Date_of_Sale
LIMIT 10;

-- Top 5 highest sales days
SELECT Date_of_Sale, SUM(Total_Sale) AS daily_sales
FROM sales_data
GROUP BY Date_of_Sale
ORDER BY daily_sales DESC
LIMIT 5;

-- Bottom 5 lowest sales days
SELECT Date_of_Sale, SUM(Total_Sale) AS daily_sales
FROM sales_data
GROUP BY Date_of_Sale
ORDER BY daily_sales ASC
LIMIT 5;

-- Top 5 days by quantity sold
SELECT Date_of_Sale, SUM(Quantity) AS total_quantity
FROM sales_data
GROUP BY Date_of_Sale
ORDER BY total_quantity DESC
LIMIT 5;

-- 7-day rolling average of daily sales
SELECT 
  Date_of_Sale,
  AVG(daily_sales) OVER (
    ORDER BY Date_of_Sale 
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS rolling_avg_7days
FROM (
  SELECT Date_of_Sale, SUM(Total_Sale) AS daily_sales
  FROM sales_data
  GROUP BY Date_of_Sale
);

-- Sales by Channel and Customer Type
SELECT Channel, Customer_Type, SUM(Total_Sale) AS combo_sales
FROM sales_data
GROUP BY Channel, Customer_Type
ORDER BY combo_sales DESC;
