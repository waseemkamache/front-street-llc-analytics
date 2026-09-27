-- Front Street Pizza: Sales Analytics
USE pizza_analytics;

-- RESULT 1: THE FINAL PRODUCT PERFORMANCE AND REVENUE GENERATED
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        ROUND(SUM(oi.line_revenue), 2) AS revenue,
        COUNT(DISTINCT oi.order_id) AS orders_containing_product,
        ROUND(
            SUM(oi.quantity) / COUNT(DISTINCT oi.order_id),
            2
        ) AS avg_units_per_order
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_name
),
product_metrics AS (
    SELECT
        RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
        product_name,
        units_sold,
        revenue,
        ROUND(
            revenue / SUM(revenue) OVER () * 100,
            2
        ) AS revenue_percentage,
        orders_containing_product,
        avg_units_per_order,
        CASE
            WHEN units_sold > 800 THEN 'High Volume'
            WHEN units_sold BETWEEN 700 AND 800 THEN 'Medium Volume'
            ELSE 'Low Volume'
        END AS sales_category
    FROM product_sales
)
SELECT *
FROM product_metrics
ORDER BY revenue_rank;

-- Average order value
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total), 2) AS total_revenue,
    ROUND(
        SUM(total) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM orders;

-- Average order items
SELECT
    SUM(quantity) AS total_items,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS average_items_per_order
FROM order_items;

-- Monthly sales analysis

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_order_value
FROM orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
    month;

-- Day of week sales analysis
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_order_value
FROM orders
GROUP BY
    DAYNAME(order_date),
    WEEKDAY(order_date)
ORDER BY
    WEEKDAY(order_date);

-- Hourly sales analysis
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(total), 2) AS revenue,
    ROUND(AVG(total), 2) AS average_order_value
FROM orders
GROUP BY
    HOUR(order_time)
ORDER BY
    order_hour;