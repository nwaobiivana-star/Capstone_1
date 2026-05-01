-- Eporium Sales Analysis 
-- Analyst: Ivana Nwaobi
-- Sales Territory: Texas 

USE sample_sales;

SELECT * FROM management WHERE SalesManager = 'Jeff "Howdy" Richards';
-- ========================================================
-- Query(Q)
-- Q1. What is total revenue overall for sales in the assigned territory, 
-- plus the start date and end date that tell you what period the data covers?
SELECT SUM(Sale_Amount) AS Total_Revenue, 
MIN(Transaction_Date) AS Start_Date,
MAX(Transaction_Date) AS End_Date
FROM store_sales
where Store_ID between 901 and 911;
-- ===========================================================================

-- Q2. What is the month by month revenue breakdown for the sales territory?
SELECT YEAR(Transaction_Date), MONTH(Transaction_Date), SUM(Sale_Amount) 
FROM Store_Sales
WHERE Store_ID between 901 and 911
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date);
-- ==================================================================

-- Q3. Provide a comparison of total revenue for your Texas territory vs the region it belongs to.
SELECT
 (SELECT SUM(Sale_Amount)
 FROM Store_Sales
 WHERE Store_ID BETWEEN 901 AND 911) AS Texas_Revenue,
 SUM(Sale_Amount) AS South_Region_Revenue
 FROM Store_Sales
JOIN Store_Locations ON Store_Sales.Store_ID = Store_Locations.StoreId
WHERE Store_Locations.State IN ('Texas', 'South Carolina', 'Florida'); 
-- ========================================================================

-- Q4. What is the number of transactions per month and average transaction size by product category for Texas?
SELECT Inventory_Categories.Category,
	MONTH(Transaction_Date) AS Month,
	COUNT(id) AS Num_Transactions,
	AVG(Sale_Amount) AS Avg_Transaction_Size
FROM Store_Sales
JOIN Store_Locations ON Store_Sales.Store_ID = Store_Locations.StoreID
JOIN Products ON Store_Sales.Prod_Num = Products.ProdNum
JOIN inventory_categories ON products.Categoryid = inventory_categories.Categoryid
WHERE Store_Locations.State = 'Texas'
GROUP BY inventory_categories.Category, month(Transaction_Date);
-- ====================================================================================

-- Q5. "Which Texas store performed best?"
SELECT Store_ID,
SUM(Sale_Amount) AS Total_Revenue
FROM Store_Sales
WHERE Store_ID between 901 and 911
GROUP BY Store_ID 
ORDER BY Total_Revenue DESC;
-- =======================================================

-- Recommendation: Where to focus on the next quarter
/* 
According to my analysis of the Texas Territory, 
 This analysis covers Texas sales data from 2022 to 2025.
The Texas territory generated a total revenue of $3,417,850.01, 
representing 43% of the entire South region, which includes 
Texas, South Carolina, and Florida. This makes Texas the 
largest contributor to the region.
Within Texas, stores range from Store 901 to 911. Store 905, 
located in Beaumont, emerged as the top performing store with 
$637,818.90 in total revenue.
 
My recommendation for the next quarter would be to focus sales 
attention on underperforming stores within the territory by using 
Store 905 Beaumont as a guide. I also recommend investing in the 
product categories with the highest average transaction sizes. 
*/


