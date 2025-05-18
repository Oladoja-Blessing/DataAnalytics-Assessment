-- Assessment_Q1.sql
-- Objective: Identify customers with both a funded savings plan and a funded investment plan,
--            and calculate their total deposits for cross-selling analysis.

-- CTE for funded savings accounts
WITH savings AS (
    SELECT 
        owner_id, 
        COUNT(*) AS savings_count, 
        SUM(new_balance) AS total_savings
    FROM savings_savingsaccount
    WHERE new_balance > 0
    GROUP BY owner_id
),

-- CTE for funded investment plans and regular savings plans
investments AS (
    SELECT 
        owner_id, 
        COUNT(*) AS investment_count, 
        SUM(amount) AS total_investments
    FROM plans_plan
    WHERE 
        (is_a_fund = 1 AND amount > 0) 
        OR (is_regular_savings = 1 AND amount > 0)
    GROUP BY owner_id
)

-- Final query: join both CTEs with users and compute total deposits
SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    s.savings_count,
    i.investment_count,
    COALESCE(s.total_savings, 0) + COALESCE(i.total_investments, 0) AS total_deposits
FROM users_customuser u
JOIN savings s ON s.owner_id = u.id
JOIN investments i ON i.owner_id = u.id
ORDER BY total_deposits DESC;