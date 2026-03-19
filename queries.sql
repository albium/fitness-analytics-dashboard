-- =========================================
-- FITNESS TRAINING SQL ANALYSIS
-- Author: Ernesto
-- Description:
-- customer engagement and trainer performance
-- =========================================

-- =========================================
-- 1. BASIC DATA EXPLORATION
-- =========================================

-- View all training sessions with customer names
SELECT
c.name AS customer,
t.name AS trainer,
ts.session_date,
ts.duration_minutes
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
JOIN trainers t ON ts.trainer_id = t.id
ORDER BY ts.session_date;

-- =========================================
-- 2. TOTAL TRAINING TIME PER CUSTOMER
-- Business Question:
-- Who are the most active customers?
-- =========================================

SELECT
c.name AS customer,
SUM(ts.duration_minutes) AS total_minutes
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name
ORDER BY total_minutes DESC;

-- =========================================
-- 3. TRAINER WORKLOAD
-- Business Question:
-- Which trainer handles the most sessions?
-- =========================================

SELECT
t.name AS trainer,
COUNT(*) AS total_sessions
FROM training_sessions ts
JOIN trainers t ON ts.trainer_id = t.id
GROUP BY t.name
ORDER BY total_sessions DESC;

-- =========================================
-- 4. AVERAGE SESSION DURATION PER CUSTOMER
-- =========================================

SELECT
c.name AS customer,
AVG(ts.duration_minutes) AS avg_session_duration
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name
ORDER BY avg_session_duration DESC;

-- =========================================
-- 5. CUSTOMERS ABOVE AVERAGE ENGAGEMENT
-- Business Question:
-- Which customers train more than average?
-- =========================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(duration_minutes) AS total_minutes
FROM training_sessions
GROUP BY customer_id
)
SELECT
c.name,
ct.total_minutes
FROM customer_totals ct
JOIN customers c ON ct.customer_id = c.id
WHERE ct.total_minutes > (
SELECT AVG(total_minutes) FROM customer_totals
);

-- =========================================
-- 6. SESSION COUNT PER CUSTOMER
-- =========================================

SELECT
c.name,
COUNT(*) AS total_sessions
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name
ORDER BY total_sessions DESC;

-- =========================================
-- 7. MOST RECENT SESSION PER CUSTOMER
-- =========================================

SELECT
c.name,
MAX(ts.session_date) AS last_session
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name;

-- =========================================
-- 8. RANK CUSTOMERS BY TOTAL TRAINING TIME
-- (WINDOW FUNCTION)
-- =========================================

SELECT
c.name,
SUM(ts.duration_minutes) AS total_minutes,
RANK() OVER (ORDER BY SUM(ts.duration_minutes) DESC) AS rank
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name;

-- =========================================
-- 9. DENSE RANK (NO GAPS IN RANKING)
-- =========================================

SELECT
c.name,
SUM(ts.duration_minutes) AS total_minutes,
DENSE_RANK() OVER (ORDER BY SUM(ts.duration_minutes) DESC) AS dense_rank
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
GROUP BY c.name;

-- =========================================
-- 10. RUNNING TOTAL OF TRAINING TIME
-- Business Question:
-- How does training accumulate over time?
-- =========================================

SELECT
c.name,
ts.session_date,
ts.duration_minutes,
SUM(ts.duration_minutes) OVER (
PARTITION BY c.name
ORDER BY ts.session_date
) AS running_total
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
ORDER BY c.name, ts.session_date;

-- =========================================
-- 11. TOP TRAINER PER CUSTOMER
-- Business Question:
-- Which trainer does each customer work with the most?
-- =========================================

SELECT *
FROM (
SELECT
c.name AS customer,
t.name AS trainer,
COUNT(*) AS session_count,
RANK() OVER (
PARTITION BY c.name
ORDER BY COUNT(*) DESC
) AS rank
FROM training_sessions ts
JOIN customers c ON ts.customer_id = c.id
JOIN trainers t ON ts.trainer_id = t.id
GROUP BY c.name, t.name
) ranked
WHERE rank = 1;

-- =========================================
-- END OF ANALYSIS
-- =========================================
