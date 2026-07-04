-- 1. Total Revenue
SELECT
    ROUND(SUM(total_amount),2) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';

-- 2. Monthly Revenue Trend
SELECT
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(total_amount),2) AS revenue
FROM orders
WHERE order_status='Delivered'
GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- 3. Top 10 Customers by Spending
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_status='Delivered'
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- 4. Average Order Value (AOV)
SELECT
    ROUND(AVG(total_amount),2) AS average_order_value
FROM orders
WHERE order_status='Delivered';

-- 5. Best Selling Products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 6. Revenue by Category
SELECT
    c.category_name,
    ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
FROM categories c
JOIN products p
ON c.category_id=p.category_id
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- 7. Revenue by Seller
SELECT
    s.seller_name,
    ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
FROM sellers s
JOIN products p
ON s.seller_id=p.seller_id
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY s.seller_name
ORDER BY revenue DESC;

-- 8. Top 5 Cities by Revenue
SELECT
    c.city,
    ROUND(SUM(o.total_amount),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_status='Delivered'
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 5;

-- 9. Order Status Distribution
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

-- 10. Payment Method Analysis
SELECT
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;

-- 11. Payment Success Rate
SELECT
    payment_status,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_status;

-- 12. Shipping Performance
SELECT
    shipping_status,
    COUNT(*) AS total_shipments
FROM shipping
GROUP BY shipping_status;

-- 13. Average Delivery Time
SELECT
    ROUND(AVG(DATEDIFF(delivery_date,shipping_date)),2)
    AS average_delivery_days
FROM shipping
WHERE delivery_date IS NOT NULL;

-- 14. Low Stock Products
SELECT
    p.product_name,
    i.stock_available,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id=p.product_id
WHERE i.stock_available<=i.reorder_level;

-- 15. Highest Rated Products
SELECT
    p.product_name,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN products p
ON r.product_id=p.product_id
GROUP BY p.product_id,p.product_name
HAVING COUNT(r.review_id)>=5
ORDER BY average_rating DESC
LIMIT 10;

-- 16. Category-wise Average Rating
SELECT
    c.category_name,
    ROUND(AVG(r.rating),2) AS average_rating
FROM reviews r
JOIN products p
ON r.product_id=p.product_id
JOIN categories c
ON p.category_id=c.category_id
GROUP BY c.category_name
ORDER BY average_rating DESC;

-- 17. Repeat Customers
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id, customer_name
HAVING COUNT(o.order_id)>1
ORDER BY total_orders DESC;

-- 18. Customer Lifetime Value (CLV)
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount),2) AS lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_status='Delivered'
GROUP BY c.customer_id, customer_name
ORDER BY lifetime_value DESC;

-- 19. Top 10 Brands by Revenue
SELECT
    p.brand,
    ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.brand
ORDER BY revenue DESC
LIMIT 10;

-- 20. Customer Type Analysis
SELECT
    customer_type,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_type;