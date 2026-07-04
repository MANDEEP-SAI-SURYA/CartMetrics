-- =====================================================
-- Trigger 1: Prevent Negative Stock
-- Purpose: Do not allow negative stock values.
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_prevent_negative_stock
BEFORE UPDATE ON inventory
FOR EACH ROW
BEGIN
    IF NEW.stock_available < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock cannot be negative.';
    END IF;
END $$

DELIMITER ;
-- Test Query
UPDATE inventory
SET stock_available = -10
WHERE product_id = 1;
-- Expected Result:
-- Error: Stock cannot be negative.

-- =====================================================
-- Trigger 2: Validate Product Rating
-- Purpose: Allow ratings only between 1 and 5.
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_validate_rating
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 5.';
    END IF;
END $$

DELIMITER ;

-- Test Query
INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1,1,10,'Excellent',CURDATE());
-- Expected Result:
-- Error: Rating must be between 1 and 5.

-- =====================================================
-- Trigger 3: Prevent Future Registration Date
-- Purpose: Registration date cannot be in the future.
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_registration_date
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.registration_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Registration date cannot be in the future.';
    END IF;
END $$

DELIMITER ;

-- Test Query
INSERT INTO customers
(first_name,last_name,gender,email,phone,city,state,
registration_date,customer_type)
VALUES
('Test','User','Male',
'test@gmail.com',
'9999999999',
'Delhi',
'Delhi',
'2035-01-01',
'Regular');
-- Expected Result:
-- Error: Registration date cannot be in the future.

SHOW TRIGGERS;