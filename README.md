# Fintech-Analytics-SQL

This project contains SQL queries developed to solve various business scenarios using a relational database containing customer, savings, and plan transaction data.

---

## Per-Question Explanations

### Assessment_Q1.sql — High-Value Customers with Multiple Products
This query identifies customers who have at least one funded savings plan and one funded investment plan.  
- Used two CTEs to aggregate savings and investment counts and sums per customer.  
- Joined user details with these aggregates to provide the customer name and total deposits.  
- Sorted by total deposits in descending order to prioritize high-value customers.

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
- Created CTEs for the last inflow transactions for savings and investment plans separately.  
- Used a union to combine these inflow dates.  
- Filtered accounts with inactivity exceeding 365 days.  
- Calculated days of inactivity using `DATEDIFF` between the current date and last transaction date.

---

### Assessment_Q4.sql — Estimated Customer Lifetime Value (CLV)
This query estimates CLV by combining customer tenure with transaction data.  
- Computed customer tenure in months from account creation date.  
- Calculated total transactions and average profit per transaction.  
- Estimated CLV by annualizing transaction frequency and multiplying by average profit per transaction.  
- Results ordered by highest estimated CLV to prioritize key customers.

---

## Challenges and Resolutions

- **MySQL vs PostgreSQL Compatibility:**  
  Initially, I tried running the queries in PostgreSQL but encountered errors due to syntax differences. After verifying that the database was designed for MySQL, I installed MySQL and completed the assessment in that environment.

- **Date Calculations:**  
  Accurately calculating customer tenure and inactivity periods required the correct use of MySQL date functions such as `TIMESTAMPDIFF` (for months) and `DATEDIFF` (for days). Ensuring these calculations were precise was key to meaningful results.

- **Aggregating and Joining Data:**  
  Combining aggregated data from savings and investment accounts posed a challenge. Using Common Table Expressions (CTEs) allowed me to clearly separate logic and then join results effectively.

- **Data Filtering Based on Business Rules:**  
  Filtering only inflow transactions (`confirmed_amount > 0`) and correctly identifying plan types with flags like `is_regular_savings` and `is_a_fund` ensured the accuracy of transaction classifications.

- **Linking Transactions to Plans:**  
  Because the savings transactions table contains all transactions, linking it with the plans table was essential to properly categorize savings and investment transactions and to retrieve accurate last transaction dates.

- **Performance and Readability:**  
  Structuring queries with CTEs helped maintain readability and query efficiency by minimizing repeated calculations and clarifying the overall logic flow.

---

Thank you!
---

**Blessing Oladoja**  

