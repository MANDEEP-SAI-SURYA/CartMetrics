-- =====================================================
-- View 1: Customer Order Summary
-- Purpose: Display customer details along with order information.
-- =====================================================

CREATE VIEW vw_customer_order_summary AS
SELECT
    o.order_id,
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    c.city,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- =====================================================
-- View 2: Product Details
-- Purpose: Display complete product information.
-- =====================================================

CREATE VIEW vw_product_details AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    s.seller_name,
    p.brand,
    p.price,
    p.discount
FROM products p
JOIN categories c
ON p.category_id = c.category_id
JOIN sellers s
ON p.seller_id = s.seller_id;

-- =====================================================
-- View 3: Product Ratings
-- Purpose: Calculate average rating of every product.
-- =====================================================

CREATE VIEW vw_product_ratings AS
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating),2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM products p
LEFT JOIN reviews r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

-- =====================================================
-- View 4: Inventory Status
-- Purpose: Identify stock availability.
-- =====================================================

CREATE VIEW vw_inventory_status AS
SELECT
    p.product_name,
    i.stock_available,
    i.reorder_level,
    i.warehouse_location,
    CASE
        WHEN i.stock_available <= i.reorder_level
            THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM inventory i
JOIN products p
ON i.product_id = p.product_id;

-- =====================================================
-- View 5: Delivered Orders
-- Purpose: Show delivered orders only.
-- =====================================================

CREATE VIEW vw_delivered_orders AS
SELECT
    o.order_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered';


SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

SELECT * FROM vw_customer_order_summary;

SELECT * FROM vw_product_details;

SELECT * FROM vw_product_ratings;

SELECT * FROM vw_inventory_status;

SELECT * FROM vw_delivered_orders;