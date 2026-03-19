# 🏋️ Fitness Training SQL Project

## 📌 Overview

This project simulates a fitness training business database to analyze customer activity, trainer performance, and overall engagement trends.

The goal is to demonstrate real-world SQL skills used in data analysis, progressing from basic queries to advanced analytical techniques.

---

## 🧱 Database Structure

The database consists of three main tables:

* **customers** → stores customer information
* **trainers** → stores trainer information
* **training_sessions** → tracks each training session

### Relationships:

* Each session is linked to:

  * one customer
  * one trainer

---

## 📂 Project Files

* `schema.sql` → Creates tables and defines relationships
* `data.sql` → Inserts structured sample data
* `queries.sql` → Contains analytical SQL queries (beginner → advanced)
* `README.md` → Project documentation

---

## 🧠 SQL Skills Demonstrated

This project showcases a range of SQL concepts:

* JOINs (combining multiple tables)
* Aggregations (SUM, COUNT, AVG)
* GROUP BY
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions (RANK, DENSE_RANK, running totals)
* Data analysis and ranking techniques

---

## 📊 Business Questions Answered

### 1. Who are the most active customers?

Calculates total training time per customer.

### 2. Which trainer handles the most sessions?

Evaluates trainer workload and engagement.

### 3. Which customers train above average?

Uses CTEs and subqueries to compare against overall averages.

### 4. Who are the top-performing customers?

Ranks customers based on total training time using window functions.

### 5. How does training accumulate over time?

Tracks running totals of session duration per customer.

### 6. Which trainer does each customer prefer?

Identifies the most frequently used trainer per customer.

---

## 🚀 Example Advanced Query (Ranking)

```sql
SELECT
  c.name,
  SUM(ts.duration_minutes) AS total_minutes,
  RANK() OVER (ORDER BY SUM(ts.duration_minutes) DESC) AS rank
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name;
```

---

## 📈 Key Insights (Example)

* Some customers consistently train more than others, indicating higher engagement
* Trainer workloads are unevenly distributed across sessions
* A small group of customers contributes the majority of training time

---

## 🛠 How to Run This Project

1. Run `schema.sql` to create tables
2. Run `data.sql` to insert data
3. Run queries from `queries.sql` to perform analysis

---

## 🎯 Purpose

This project is part of a learning journey toward becoming a data analyst. It demonstrates the ability to:

* Design relational databases
* Write structured and efficient SQL queries
* Analyze and interpret data using real-world scenarios

---

## 📌 Future Improvements

* Add customer signup tracking for retention analysis
* Include revenue metrics per session
* Build a dashboard (Power BI / Tableau)
* Expand dataset for deeper trend analysis

---

## 👤 Author

Ernesto

---
