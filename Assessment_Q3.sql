-- Assessment_Q3.sql
-- Objective: Identify active savings and investment plans with no inflow transactions
--            in the last 365 days, to flag for account inactivity alerts.

-- Step 1: Get the last inflow date for savings accounts
WITH savings_last_inflow AS (
    SELECT 
        p.id AS plan_id,
        s.owner_id,
        'Savings' AS type,
        MAX(s.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount s
    JOIN plans_plan p ON p.id = s.plan_id
    WHERE p.is_regular_savings = 1 AND s.confirmed_amount > 0
    GROUP BY p.id, s.owner_id
),

-- Step 2: Get the last inflow date for investment accounts
investment_last_inflow AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        'Investment' AS type,
        MAX(sa.transaction_date) AS last_transaction_date
    FROM plans_plan p
    JOIN savings_savingsaccount sa ON sa.plan_id = p.id
    WHERE p.is_a_fund = 1 AND sa.confirmed_amount > 0
    GROUP BY p.id, p.owner_id
),

-- Step 3: Combine savings and investment last inflows
combined_last_inflows AS (
    SELECT * FROM savings_last_inflow
    UNION ALL
    SELECT * FROM investment_last_inflow
)

-- Step 4: Filter for accounts with over one year of inactivity
SELECT 
    cli.plan_id,
    cli.owner_id,
    cli.type,
    cli.last_transaction_date,
    DATEDIFF(CURDATE(), cli.last_transaction_date) AS inactivity_days
FROM combined_last_inflows cli
WHERE DATEDIFF(CURDATE(), cli.last_transaction_date) > 365
ORDER BY inactivity_days DESC;