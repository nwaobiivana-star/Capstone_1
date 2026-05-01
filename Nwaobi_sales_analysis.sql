-- Eporium Sales Analysis 
-- Analyst: Ivana Nwaobi
-- Sales Territory: Texas 

USE sample_sales;

SELECT * FROM management WHERE SalesManager = 'Jeff "Howdy" Richards';

SELECT SUM(Sale_Amount) AS Total_Revenue, 
MIN(Transaction_Date) AS Start_Date,
MAX(Transaction_Date) AS End_Date
FROM store_sales
where Store_ID between 901 and 911