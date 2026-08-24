-- ============================================
-- SALES ANALYTICS PROJECT
-- Database: sales_analysis
-- Table: sales
-- ============================================

USE sales_analysis;


-- 01. Overall KPIs
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin,
    ROUND(SUM(Sales) / COUNT(*), 2) AS Average_Order_Value
FROM sales;


-- 02. Sales by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Category
ORDER BY Total_Sales DESC;


-- 03. Profit by Region
SELECT
    Region,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Region
ORDER BY Total_Profit DESC;


-- 04. Top 10 Products by Sales
SELECT
    Product,
    SUM(Sales) AS Total_Sales
FROM sales
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;


-- 05. Monthly Sales & Profit
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Month_Number;


-- 06. Payment Method Analysis
SELECT
    Payment_Method,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;


-- 07. Overall Profit Margin
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent
FROM sales;


-- 08. Category-wise Profit Margin
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent
FROM sales
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;


-- 09. Top 10 Products by Profit
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent
FROM sales
GROUP BY Product
ORDER BY Total_Profit DESC
LIMIT 10;


-- 10. Bottom 10 Products by Profit
SELECT
    Product,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent
FROM sales
GROUP BY Product
ORDER BY Total_Profit ASC
LIMIT 10;


-- 11. Customer Analysis
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;


-- 12. CASE WHEN Analysis
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)
        AS Profit_Margin_Percent,

    CASE
        WHEN SUM(Profit) / SUM(Sales) >= 0.40
            THEN 'High Margin'
        WHEN SUM(Profit) / SUM(Sales) >= 0.25
            THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS Margin_Category

FROM sales
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;


-- 13. Customer Ranking
SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Sales_Rank;


-- 14. Running Sales Total
SELECT
    Order_Date,
    Sales,
    SUM(Sales) OVER (
        ORDER BY Order_Date
    ) AS Running_Sales
FROM sales
ORDER BY Order_Date;
