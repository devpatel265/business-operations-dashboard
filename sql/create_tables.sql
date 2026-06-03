/*
Business Operations Dashboard
File: create_tables.sql

Purpose:
This script creates a small relational database for a business analytics
portfolio project. The design is intentionally beginner-friendly while still
showing realistic business entities:

1. customers    - who buys from the company
2. products     - what the company sells
3. orders       - order headers, one row per customer purchase
4. transactions - order line items, one row per product sold in an order

SQL dialect:
This script uses standard SQL with PostgreSQL-friendly data types.
It can be adapted for SQL Server, MySQL, or SQLite with minor changes.
*/

-- Drop child tables first because they reference parent tables.
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

/*
The customers table stores one row per customer.
signup_date allows us to analyze customer growth over time.
*/
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    segment VARCHAR(50) NOT NULL,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL
);

/*
The products table stores one row per product.
category supports reporting such as revenue by category.
unit_price is the standard selling price before discounts.
*/
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0)
);

/*
The orders table stores one row per order.
An order belongs to one customer, but it can contain multiple products.
order_status helps filter completed, pending, or cancelled activity.
*/
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    sales_channel VARCHAR(30) NOT NULL,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

/*
The transactions table stores the products sold within each order.
This is the table analysts usually aggregate for revenue and quantity metrics.
line_total is stored here to keep the sample project simple for beginners.
In a production database, line_total may be calculated instead.
*/
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    discount_amount DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
    line_total DECIMAL(10, 2) NOT NULL CHECK (line_total >= 0),
    CONSTRAINT fk_transactions_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_transactions_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Helpful indexes for common reporting filters and joins.
CREATE INDEX idx_customers_signup_date ON customers(signup_date);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_transactions_order_id ON transactions(order_id);
CREATE INDEX idx_transactions_product_id ON transactions(product_id);
