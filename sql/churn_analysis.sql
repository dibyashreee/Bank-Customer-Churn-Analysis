-- Create table
CREATE TABLE churn_data (
    customerid BIGINT,
    surname VARCHAR(100),
    creditscore INT,
    geography VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance NUMERIC(15,2),
    numofproducts INT,
    hascrcard INT,
    isactivemember INT,
    estimatedsalary NUMERIC(15,2),
    exited INT
);


-- Query 1: Overall churn rate
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_percent 
FROM churn_data;


-- Query 2: Churn rate by country
SELECT 
    geography,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_percent
FROM churn_data
GROUP BY geography
ORDER BY churn_rate_percent DESC;


-- Query 3: Churn rate by gender
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_percent
FROM churn_data
GROUP BY gender
ORDER BY churn_rate_percent DESC;


-- Query 4: Churn rate by number of products
SELECT 
    numofproducts,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_percent
FROM churn_data
GROUP BY numofproducts
ORDER BY churn_rate_percent DESC;


-- Query 5: Average balance and credit score by churn status
SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Retained'
    END AS customer_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(balance), 2) AS avg_balance,
    ROUND(AVG(creditscore), 2) AS avg_credit_score
FROM churn_data
GROUP BY exited
ORDER BY exited;


-- Query 6: Churn by tenure bucket
SELECT 
    CASE 
        WHEN Tenure BETWEEN 0 AND 2 THEN '0-2 Years'
        WHEN Tenure BETWEEN 3 AND 5 THEN '3-5 Years'
        ELSE '6+ Years'
    END AS tenure_bucket,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS churn_rate_percent
FROM churn_data
GROUP BY tenure_bucket
ORDER BY tenure_bucket;
