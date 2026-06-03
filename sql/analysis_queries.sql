/*
Business Operations Dashboard
File: analysis_queries.sql

Purpose:
This file contains beginner-friendly SQL analysis queries used to build
the dashboard and explain business performance.

Important note:
Most queries filter to order_status = 'Completed'. This keeps pending orders
from being counted as revenue.
*/

/*
Query 1: Total revenue, total orders, and total customers

Business question:
How much revenue did the business earn, how many completed orders were placed,
and how many customers are in the customer base?

How it works:
- SUM(t.line_total) adds all completed transaction revenue.
- COUNT(DISTINCT o.order_id) counts each completed order only once.
- COUNT(DISTINCT c.customer_id) counts each customer only once.
*/
SELECT
    ROUND(SUM(t.line_total), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_completed_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM transactions t
JOIN orders o
    ON t.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Completed';

/*
Query 2: Revenue by month

Business question:
Is revenue increasing, decreasing, or fluctuating over time?

How it works:
- DATE_TRUNC('month', order_date) groups orders into calendar months.
- SUM(line_total) calculates revenue for each month.
- COUNT(DISTINCT order_id) shows order volume behind each monthly result.
*/
SELECT
    DATE_TRUNC('month', o.order_date) AS revenue_month,
    ROUND(SUM(t.line_total), 2) AS monthly_revenue,
    COUNT(DISTINCT o.order_id) AS completed_orders
FROM transactions t
JOIN orders o
    ON t.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY revenue_month;

/*
Query 3: Revenue by product category

Business question:
Which product categories contribute the most revenue?

How it works:
- Joins transactions to products so each sale has a category.
- Groups revenue by product category.
- Calculates each category's share of total revenue with a window function.
*/
SELECT
    p.category,
    ROUND(SUM(t.line_total), 2) AS category_revenue,
    ROUND(
        SUM(t.line_total) * 100.0 / SUM(SUM(t.line_total)) OVER (),
        2
    ) AS percent_of_total_revenue
FROM transactions t
JOIN orders o
    ON t.order_id = o.order_id
JOIN products p
    ON t.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY category_revenue DESC;

/*
Query 4: Top customers by spending

Business question:
Which customers are the highest-value accounts?

How it works:
- Groups completed transaction revenue by customer.
- Counts completed orders per customer.
- Calculates average order value for each customer.
*/
SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    c.city,
    c.state,
    ROUND(SUM(t.line_total), 2) AS total_spending,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(t.line_total) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN transactions t
    ON o.order_id = t.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.segment,
    c.city,
    c.state
ORDER BY total_spending DESC
LIMIT 10;

/*
Query 5: Top products by sales

Business question:
Which products sell the most by revenue and quantity?

How it works:
- Groups completed sales by product.
- SUM(quantity) measures units sold.
- SUM(line_total) measures revenue.
- Results are sorted by product revenue.
*/
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(t.quantity) AS units_sold,
    ROUND(SUM(t.line_total), 2) AS product_revenue
FROM products p
JOIN transactions t
    ON p.product_id = t.product_id
JOIN orders o
    ON t.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY product_revenue DESC
LIMIT 10;

/*
Query 6: Customer growth trends

Business question:
How quickly is the customer base growing month by month?

How it works:
- Groups customers by signup month.
- COUNT(customer_id) shows new customers added each month.
- SUM(COUNT(*)) OVER creates a running total of customers over time.
*/
SELECT
    DATE_TRUNC('month', signup_date) AS signup_month,
    COUNT(customer_id) AS new_customers,
    SUM(COUNT(customer_id)) OVER (
        ORDER BY DATE_TRUNC('month', signup_date)
    ) AS cumulative_customers
FROM customers
GROUP BY DATE_TRUNC('month', signup_date)
ORDER BY signup_month;

/*
Query 7: Customer distribution by state

Business question:
Where are customers located?

How it works:
- Groups customers by state.
- Counts customers in each state.
- This query supports a map visual, bar chart, or table in Power BI.
*/
SELECT
    state,
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY state
ORDER BY customer_count DESC, state;

/*
Query 8: Monthly revenue with month-over-month change

Business question:
How much did revenue change compared with the previous month?

How it works:
- The monthly_revenue common table expression calculates revenue per month.
- LAG(monthly_revenue) brings in the previous month's revenue.
- The final calculation shows the percentage change month over month.
*/
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS revenue_month,
        SUM(t.line_total) AS monthly_revenue
    FROM transactions t
    JOIN orders o
        ON t.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    revenue_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(LAG(monthly_revenue) OVER (ORDER BY revenue_month), 2) AS previous_month_revenue,
    ROUND(
        (
            monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY revenue_month)
        ) * 100.0 / NULLIF(LAG(monthly_revenue) OVER (ORDER BY revenue_month), 0),
        2
    ) AS month_over_month_percent_change
FROM monthly_revenue
ORDER BY revenue_month;
