-- Day 3 SQL Basics

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT,
    city TEXT
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC,
    created_at DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (name, city) VALUES
('Alice', 'New York'),
('Bob', 'Chicago'),
('Charlie', 'Los Angeles');

INSERT INTO orders (customer_id, amount, created_at) VALUES
(1, 120, '2024-01-01'),
(1, 300, '2024-02-01'),
(2, 180, '2024-02-15'),
(3, 500, '2024-03-01'),
(3, 130, '2024-03-10');

-- Queries
SELECT * FROM customers;
SELECT * FROM orders WHERE amount > 200;

SELECT c.name, o.amount, o.created_at
FROM customers c
JOIN orders o ON c.id = o.customer_id;

SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.name;