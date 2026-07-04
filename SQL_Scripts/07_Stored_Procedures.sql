-- =====================================================
-- Procedure 1: Get Orders by Customer
-- Purpose: Display all orders of a given customer.
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(IN p_customer_id INT)
BEGIN
    SELECT
        order_id,
        order_date,
        order_status,
        total_amount
    FROM orders
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

CALL GetCustomerOrders(101);

-- =====================================================
-- Procedure 2: Get Products by Category
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetProductsByCategory(IN p_category_id INT)
BEGIN
    SELECT
        product_name,
        brand,
        price,
        discount
    FROM products
    WHERE category_id = p_category_id;
END $$

DELIMITER ;

CALL GetProductsByCategory(3);

-- =====================================================
-- Procedure 3: Customer Total Spending
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetCustomerSpending(IN p_customer_id INT)
BEGIN
    SELECT
        customer_id,
        ROUND(SUM(total_amount),2) AS total_spending
    FROM orders
    WHERE customer_id = p_customer_id
    GROUP BY customer_id;
END $$

DELIMITER ;

CALL GetCustomerSpending(101);

-- =====================================================
-- Procedure 4: Low Stock Products
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetLowStockProducts()
BEGIN
    SELECT
        p.product_name,
        i.stock_available,
        i.reorder_level
    FROM inventory i
    JOIN products p
        ON i.product_id = p.product_id
    WHERE i.stock_available <= i.reorder_level;
END $$

DELIMITER ;

CALL GetLowStockProducts();

-- =====================================================
-- Procedure 5: Monthly Revenue
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetMonthlyRevenue()
BEGIN
    SELECT
        YEAR(order_date) AS year,
        MONTHNAME(order_date) AS month,
        ROUND(SUM(total_amount),2) AS revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
    ORDER BY YEAR(order_date), MONTH(order_date);
END $$

DELIMITER ;

CALL GetMonthlyRevenue();

SHOW PROCEDURE STATUS
WHERE Db = 'shopsphere';