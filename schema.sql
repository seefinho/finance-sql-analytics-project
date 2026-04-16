CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    revenue DECIMAL(10,2)
);
