# DataAnalytics-Assessment

Welcome to the Data Analytics SQL Proficiency Assessment repository. This project contains SQL queries developed to solve various business scenarios using a relational database containing customer, savings, and plan transaction data.

---

## Per-Question Explanations

### Assessment_Q1.sql — High-Value Customers with Multiple Products
This query identifies customers who have at least one funded savings plan and one funded investment plan.  
- Used two CTEs to aggregate savings and investment counts and sums per customer.  
- Joined user details with these aggregates to provide the customer name and total deposits.  
- Sorted by total deposits descending to prioritize high-value customers.

---

### Assessment_Q2.sql — Customer Transaction Frequency Segmentation
This query segments customers into frequency categories based on their average monthly transactions.  
- Calculated monthly transaction counts per customer using date formatting and aggregation.  
- Derived average transactions per month per customer.  
- Categorized customers into 'High', 'Medium', and 'Low' frequency buckets based on thresholds.  
- Aggregated results to show customer counts and average transactions by category.

---

### Assessment_Q3.sql — Account Inactivity Alert
This query flags active savings and investment accounts with no inflow transactions in the last year.  
- Created CTEs for last inflow transactions for savings and investment plans separately.  
- Used a union to combine these inflow dates.  
- Filtered accounts with inactivity exceeding 365 days.  
- Calculated days of inactivity using `DATEDIFF` between current date and last transaction date.

---

### Assessment_Q4.sql — Estimated Customer Lifetime Value (CLV)
This query estimates CLV by combining customer tenure with transaction data.  
- Computed customer tenure in months from account creation date.  
- Calculated total transactions and average profit per transaction.  
- Estimated CLV by annualizing transaction frequency and multiplying by average profit per transaction.  
- Results ordered by highest estimated CLV to prioritize key customers.

---

## Challenges and Resolutions

- **Handling Date Calculations:** Accurately computing tenure and inactivity required using appropriate date functions like `TIMESTAMPDIFF` and `DATEDIFF`. Confirmed correct usage for months and days to ensure precise results.  
- **Joining Aggregated Data:** Combining aggregated data from savings and investment tables necessitated careful use of CTEs and joins to maintain performance and clarity.  
- **Data Filtering Criteria:** Ensured that inflow transactions were properly filtered using `confirmed_amount > 0` and relevant plan type flags to avoid incorrect inclusions.  
- **Performance Considerations:** Used CTEs and limited aggregation scopes to maintain query efficiency while ensuring readability.

---

Thank you for reviewing my Data Analytics SQL Assessment submission. I look forward to your feedback.

---

**Blessing Oladoja**  

