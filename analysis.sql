-- 1. Total revenue per customer
SELECT c.customer_name, SUM(o.revenue) AS total_revenue
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

-- 2. Top customers by revenue
SELECT c.customer_name, SUM(o.revenue) AS total_revenue
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;

-- 3. Daily revenue
SELECT order_date, SUM(revenue) AS daily_revenue
FROM orders
GROUP BY order_date;

-- 4. Customer segmentation
SELECT c.customer_name,
       SUM(o.revenue) AS total_revenue,
       CASE 
           WHEN SUM(o.revenue) > 30 THEN 'High Value'
           WHEN SUM(o.revenue) BETWEEN 10 AND 30 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS segment
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;
