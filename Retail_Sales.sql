-- SQL RETAIL SALES ANALYSIS - PROJECT 3

-- CREATING TABLES
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id	INT,
				sale_date DATE,	
				sale_time TIME,	
				customer_id	INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),	
				quantity	INT,
				price_per_unit FLOAT,	
				cogs FLOAT,
				total_sale FLOAT
			);
SELECT * FROM retail_sales
LIMIT 10;

SELECT
	COUNT(*) AS total_rows
FROM retail_sales
;

--Check for Null Values in any column

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
;

--Deleting rows where Null Values are found

DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
;


--DATA EXPLORATION


-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS total_sale
FROM retail_sales
;

--How many customers do we have ?
SELECT COUNT(DISTINCT customer_id) AS total_number_of_customers
FROM retail_sales
;

-- WHAT ARE THE DIFFERENT DICTINCT CATEGORIES
SELECT DISTINCT category FROM retail_sales;



--DATA ANALYSIS AND BUSINESS PROBLEMS
-- Q1.RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05' 

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05' 
;

--Q2. RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND QUANTITY SOLD IS MORE THAN EQUAL TO 4 IN THE MONTH OF NOV-2022

SELECT *
FROM retail_sales
WHERE 
	CATEGORY = 'Clothing'
	AND
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND
	quantity >= 4
;

--Q3. TO FIND THE TOTAL SALES FOR EACH CATEGORY

SELECT 
	category, 
	SUM(total_sale) AS total_sales,
	COUNT (total_sale) AS total_order
FROM retail_sales
GROUP BY category
;

--Q4. Find the average age of customers who purchased item from the 'beauty' category

SELECT 
	category,
	ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE
	category = 'Beauty'
GROUP BY category
;


--Q5.Find all transactions where the total sale is greater than 1000.
SELECT * 
FROM retail_sales
WHERE total_sale>1000
;

-- Q6. Find the total number of transactions made by each gender in each category
SELECT 
	category,
	gender,
	COUNT(transactions_id) AS tot_transactions
FROM retail_sales
GROUP BY 1,2
ORDER BY 1
;


-- Q7. Find the avg sale for each month. Find the best selling month in each year.
SELECT 
	EXTRACT (YEAR FROM sale_date) as year,
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC
;


--Q8. Find top 5 customers based on the highest total sales
SELECT 
	customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
;

--Q9. Find the number of unique customer who purchased items from each category.

SELECT 
	category,
	COUNT(DISTINCT(customer_id)) AS dictinct_customer
FROM retail_sales
GROUP BY 1
;


--Q10.To create each shift and number of orders (Eg: Morning<=12,Afternoon b/w 12 and 17, Evening > 17)
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
;

--End of Project