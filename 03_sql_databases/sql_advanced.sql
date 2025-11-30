-- Day 4 - Advanced SQL: GROUP BY, HAVING, Window Functions

-- Sanity checks
SELECT * FROM customers;
SELECT * FROM orders;

-- 1) Total spent per customer
SELECT
    c.id,
    c.name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

-- 2) Customers spending more than 300
SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.name
HAVING SUM(o.amount) > 300
ORDER BY total_spent DESC;

-- 3) Rank customers by total spend (window function)
SELECT
    c.name,
    o.amount,
    o.created_at,
    SUM(o.amount) OVER (PARTITION BY c.id) AS customer_total,
    RANK() OVER (ORDER BY SUM(o.amount) OVER (PARTITION BY c.id) DESC) AS spend_rank
FROM customers c
JOIN orders o ON o.customer_id = c.id
ORDER BY spend_rank, c.name, o.created_at;

-- 4) Running total per customer over time
SELECT
    c.name,
    o.created_at,
    o.amount,
    SUM(o.amount) OVER (
        PARTITION BY c.id
        ORDER BY o.created_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM customers c
JOIN orders o ON o.customer_id = c.id
ORDER BY c.name, o.created_at;