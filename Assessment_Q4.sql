-- Assessment_Q4.sql
-- Objective: Estimate Customer Lifetime Value (CLV) using transaction data, 
--            tenure, and a derived profit-per-transaction metric.

-- Step 1: Calculate customer tenure in months
WITH tenure AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, created_on, CURDATE()) AS tenure_months
    FROM users_customuser
),

-- Step 2: Calculate average profit per transaction for each customer
profit AS (
    SELECT 
        owner_id AS customer_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) * 0.001 / COUNT(*) AS avg_profit_per_trx
    FROM savings_savingsaccount
    GROUP BY owner_id
)

-- Step 3: Estimate CLV using transaction rate, tenure, and average profit
SELECT 
    t.customer_id,
    t.name,
    t.tenure_months,
    p.total_transactions,
    ROUND(p.total_transactions / t.tenure_months * 12 * p.avg_profit_per_trx, 2) AS estimated_clv
FROM tenure t
JOIN profit p ON p.customer_id = t.customer_id
ORDER BY estimated_clv DESC;