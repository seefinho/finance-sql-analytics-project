-- =========================================
-- FINANCE & REVENUE ANALYTICS PROJECT
-- Analysis Queries
-- =========================================

-- 1. Total revenue per customer
SELECT 
    c.customer_name,
    SUM(o.revenue) AS total_revenue
FROM orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name;


-- 2. Customers ranked by total revenue
SELECT 
    c.customer_name,
    SUM(o.revenue) AS total_revenue,
    RANK() OVER (ORDER BY SUM(o.revenue) DESC) AS revenue_rank
FROM orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name;


-- 3. Top 2 customers by revenue
SELECT *
FROM (
    SELECT 
        c.customer_name,
        SUM(o.revenue) AS total_revenue,
        RANK() OVER (ORDER BY SUM(o.revenue) DESC) AS rnk
    FROM orders o
    INNER JOIN customers c 
    ON o.customer_id = c.customer_id
    GROUP BY c.customer_name
) ranked_customers
WHERE rnk <= 2;


-- 4. Daily revenue trend
SELECT 
    order_date,
    SUM(revenue) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;


-- 5. Customer segmentation (business logic)
SELECT 
    c.customer_name,
    SUM(o.revenue) AS total_revenue,
    CASE 
        WHEN SUM(o.revenue) >= 30 THEN 'High Value'
        WHEN SUM(o.revenue) BETWEEN 10 AND 29 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name;


-- 6. Top product per category (window function)
SELECT *
FROM (
    SELECT 
        p.category,
        p.product_name,
        SUM(o.revenue) AS total_revenue,
        RANK() OVER (
            PARTITION BY p.category 
            ORDER BY SUM(o.revenue) DESC
        ) AS rnk
    FROM orders o
    INNER JOIN products p 
    ON o.product_id = p.product_id
    GROUP BY p.category, p.product_name
) ranked_products
WHERE rnk = 1;
