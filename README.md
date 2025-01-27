# RETAIL SALES ANALYSIS USING SQL PROJECT
![RETAIL SALES LOGO](https://github.com/BERLINSAMUELRAJ/RETAIL-SALES-ANALYSIS-SQL-/blob/main/RETAIL-17-5-2024.jpg)
## Project Overview
**Project Title:** Retail Sales Analysis  
**Database:** `RETAIL_SALES_DB`  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives
- **Set up a retail sales database:** Create and populate a retail sales database with the provided sales data.
- **Data Cleaning:** Identify and remove any records with missing or null values.
- **Exploratory Data Analysis (EDA):** Perform basic exploratory data analysis to understand the dataset.
- **Business Analysis:** Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup
#### Database Creation
The project starts by creating a database named `RETAIL_SALES_DB`.

#### Table Creation
A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

### SQL Script to Create Database and Table
```sql
CREATE DATABASE RETAIL_SALES_DB;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,    
    sale_time TIME,
    customer_id INT,    
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,    
    cogs FLOAT,
    total_sale FLOAT
);
```
### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

**Record Count: Determine the total number of records in the dataset.**:
```sql
SELECT COUNT(*) AS "COUNT" FROM RETAIL_SALES_ANALYSIS
```
**Customer Count: Find out how many unique customers are in the dataset.**:
```sql
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS "TOTAL CUSTOMERS" FROM RETAIL_SALES_ANALYSIS
```
**Category Count: Identify all unique product categories in the dataset.**:
```sql
SELECT DISTINCT(CATEGORY) AS "NO OF CATEGORIES" FROM RETAIL_SALES_ANALYSIS 
```
**Null Value Check: Check for any null values in the dataset and delete records with missing data.**:
```sql
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR SALE_TIME IS NULL OR
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR
QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL OR TOTAL_SALE IS NULL

DELETE FROM RETAIL_SALES_ANALYSIS
WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR SALE_TIME IS NULL OR
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR
QUANTITY IS NULL OR PRICE_PER_UNIT IS NULL OR COGS IS NULL OR TOTAL_SALE IS NULL
```
### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE SALE_DATE='2022-11-05';
GO
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Clothing' AND 
QUANTITY>4 AND 
YEAR(SALE_DATE)=2022 AND
MONTH(SALE_DATE)=11;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT CATEGORY, SUM(TOTAL_SALE) AS "TOTAL SALES" , COUNT(*) AS "TOTAL ORDERS"  FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Clothing'
GROUP BY CATEGORY;

```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT CATEGORY, AVG(AGE) AS "AVERAGE AGE" FROM RETAIL_SALES_ANALYSIS
WHERE CATEGORY='Beauty'
GROUP BY CATEGORY;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM RETAIL_SALES_ANALYSIS
WHERE TOTAL_SALE>1000
ORDER BY TOTAL_SALE DESC;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT CATEGORY, GENDER, COUNT(*) AS "NO OF TRANSACTIONS" FROM RETAIL_SALES_ANALYSIS
GROUP BY CATEGORY, GENDER;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
WITH TOP5_CTE AS(
	SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS "TOTAL SALES",
	DENSE_RANK() OVER(ORDER BY SUM(TOTAL_SALE) DESC) AS "RANK"
	FROM [RETAIL_SALES_ANALYSIS ]
	GROUP BY customer_id 
)
SELECT * FROM TOP5_CTE
WHERE RANK<=5;
GO
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS "TOTAL CUSTOMERS" FROM [RETAIL_SALES_ANALYSIS ]
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
