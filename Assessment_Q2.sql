-- Assessment_Q2.sql
-- Objective: Categorize customers based on their average number of monthly transactions
--            to help segment them into frequency tiers for targeted marketing.

-- Step 1: Calculate transaction count per customer per month
WITH customer_monthly_tx AS (
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS month,
        COUNT(*) AS monthly_tx_count
    FROM savings_savingsaccount s
    GROUP BY s.owner_id, month
),

-- Step 2: Calculate average monthly transactions per customer
avg_tx_per_customer AS (
    SELECT 
        owner_id,
        ROUND(AVG(monthly_tx_count), 0) AS avg_tx_per_month
    FROM customer_monthly_tx
    GROUP BY owner_id
),

-- Step 3: Categorize customers based on frequency
categorized_customers AS (
    SELECT 
        CASE 
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_tx_per_month
    FROM avg_tx_per_customer
)

-- Step 4: Aggregate final results by category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');