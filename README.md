# RETAIL SALES ANALYSIS USING SQL PROJECT
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
**1. Record Count: Determine the total number of records in the dataset.**:
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
