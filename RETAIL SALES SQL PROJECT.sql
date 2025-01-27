USE RETAIL_SALES_DB;
GO

SELECT * FROM RETAIL_SALES_ANALYSIS;
GO

EXEC sp_rename 'RETAIL_SALES_ANALYSIS.QUANTIY', 'QUANTITY', 'COLUMN';


--Data Exploration & Cleaning--

--1.Record Count: Determine the total number of records in the dataset.

SELECT COUNT(*) AS "COUNT" FROM RETAIL_SALES_ANALYSIS

--2.Customer Count: Find out how many unique customers are in the dataset.

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS "TOTAL CUSTOMERS" FROM RETAIL_SALES_ANALYSIS

--3.Category Count: Identify all unique product categories in the dataset.

SELECT DISTINCT(CATEGORY) AS "NO OF CATEGORIES" FROM RETAIL_SALES_ANALYSIS 

--4.Null Value Check: Check for any null values in the dataset and delete records with missing data.

SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR SALE_TIME IS NULL OR
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR
QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL OR TOTAL_SALE IS NULL

DELETE FROM RETAIL_SALES_ANALYSIS
WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR SALE_TIME IS NULL OR
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR
QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL OR TOTAL_SALE IS NULL


--Data Analysis & Findings--

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE SALE_DATE='2022-11-05';
GO

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Clothing' AND 
QUANTITY>4 AND 
YEAR(SALE_DATE)=2022 AND
MONTH(SALE_DATE)=11;

--3.Write a SQL query to calculate the total sales (total_sale) for each category:

SELECT CATEGORY, SUM(TOTAL_SALE) AS "TOTAL SALES" , COUNT(*) AS "TOTAL ORDERS"  FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Clothing'
GROUP BY CATEGORY;

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT CATEGORY, AVG(AGE) AS "AVERAGE AGE" FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Beauty'
GROUP BY CATEGORY;

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE TOTAL_SALE>1000
ORDER BY TOTAL_SALE DESC;


--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT CATEGORY, GENDER, COUNT(*) AS "NO OF TRANSACTIONS" FROM RETAIL_SALES_ANALYSIS
GROUP BY CATEGORY, GENDER;


--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH AVG_SALES AS (
	SELECT DISTINCT YEAR(SALE_DATE) AS "YEAR",  
	FORMAT(SALE_DATE,'MMMM') AS "MONTH",
	MONTH(SALE_DATE) AS "MONTH NO",
	ROUND(AVG(TOTAL_SALE),3) AS "AVG SALES"
	FROM RETAIL_SALES_ANALYSIS
	GROUP BY YEAR(SALE_DATE), FORMAT(SALE_DATE,'MMMM'), MONTH(SALE_DATE)
)

SELECT * FROM AVG_SALES
ORDER BY YEAR, "MONTH NO";

--8.Write a SQL query to find the top 5 customers based on the highest total sales

WITH TOP5_CTE AS(
	SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS "TOTAL SALES",
	DENSE_RANK() OVER(ORDER BY SUM(TOTAL_SALE) DESC) AS "RANK"
	FROM [RETAIL_SALES_ANALYSIS ]
	GROUP BY customer_id 
)
SELECT * FROM TOP5_CTE
WHERE RANK<=5;
GO


--9.Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS "TOTAL CUSTOMERS" FROM [RETAIL_SALES_ANALYSIS ]
GROUP BY category;


--10.Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH SHIFT_CTE AS(
SELECT CASE 
			WHEN DATEPART(HOUR,sale_time) <12 THEN 'MORNING'
			WHEN DATEPART(HOUR,sale_time) >=12 AND DATEPART(HOUR,sale_time) <=17  THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,sale_time) >17 THEN 'EVENING'
			ELSE 'UNTIME'
			END AS "SHIFT TIMINGS",
	  COUNT(transactions_id) AS "TOTAL ORDERS" FROM [RETAIL_SALES_ANALYSIS ]
GROUP BY CASE 
			WHEN DATEPART(HOUR,sale_time) <12 THEN 'MORNING'
			WHEN DATEPART(HOUR,sale_time) >=12 AND DATEPART(HOUR,sale_time) <=17  THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,sale_time) >17 THEN 'EVENING'
			ELSE 'UNTIME'
			END
)
SELECT * FROM SHIFT_CTE
ORDER BY [TOTAL ORDERS] DESC