-- =====================================================
-- This file contains indexes to improve query performance.
-- =====================================================

-- =====================================================
-- Index 1: Customer ID Index
-- =====================================================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

-- =====================================================
-- Index 2: Order Date Index
-- =====================================================

CREATE INDEX idx_orders_date
ON orders(order_date);

-- =====================================================
-- Index 3: Category Index
-- =====================================================

CREATE INDEX idx_products_category
ON products(category_id);

-- =====================================================
-- Index 4: Seller Index
-- =====================================================

CREATE INDEX idx_products_seller
ON products(seller_id);

-- =====================================================
-- Index 5: Product Index
-- =====================================================

CREATE INDEX idx_orderitems_product
ON order_items(product_id);

-- =====================================================
-- Index 6: Review Product Index
-- =====================================================

CREATE INDEX idx_reviews_product
ON reviews(product_id);

-- =====================================================
-- Index 7: Payment Status Index
-- =====================================================

CREATE INDEX idx_payments_status
ON payments(payment_status);

-- =====================================================
-- Display all indexes in the ShopSphere database
-- =====================================================

SHOW INDEX FROM customers;
SHOW INDEX FROM products;
SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;
SHOW INDEX FROM reviews;
SHOW INDEX FROM payments;