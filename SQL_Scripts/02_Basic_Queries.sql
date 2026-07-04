USE shopsphere;

-- Q1. Display all records from the Customers table.
SELECT * FROM customers;

-- Q2. Display all records from the Products table.
SELECT * FROM products;

-- Q3. Display all records from the Orders table.
SELECT * FROM orders;

-- Q4. Display the first name, last name, and email address of all customers.
SELECT first_name, last_name, email FROM customers;

-- Q5. Display the product name, brand, and price of all products.
SELECT product_name, brand, price FROM products;

-- Q6. Retrieve all Premium customers.
SELECT * FROM customers WHERE customer_type = 'Premium';

-- Q7. Display all Delivered orders.
SELECT * FROM orders WHERE order_status = 'Delivered';

-- Q8. Display products costing more than ₹50,000.
SELECT product_name FROM products WHERE price > 50000;

-- Q9. Display customers from Delhi.
SELECT * FROM customers WHERE city='Delhi';

-- Q10. Display products with discount greater than 20%.
SELECT * FROM products WHERE discount>20;

-- Q11. Display products sorted by highest price.
SELECT * FROM products ORDER BY price DESC;

-- Q12. Display customers sorted alphabetically by first and last name.
SELECT * FROM customers ORDER BY first_name,last_name;

-- Q13. Display orders sorted by latest order date.
SELECT * FROM orders ORDER BY order_date DESC;

-- Q14. Display the top 10 most expensive products.
SELECT * FROM products ORDER BY price DESC LIMIT 10;

-- Q15. Display the latest 5 orders.
SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

-- Q16. Display all orders placed in the year 2024.
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Q17. Display products priced between ₹1,000 and ₹5,000.
SELECT * FROM products WHERE price BETWEEN 1000 AND 5000;

-- Q18. Display customers whose first name starts with 'A'.
SELECT * FROM customers WHERE first_name LIKE 'A%';

-- Q19. Display products whose name contains 'Phone'.
SELECT * FROM products WHERE product_name LIKE '%Phone%';

-- Q20. Display orders with status Delivered or Shipped.
SELECT * FROM orders WHERE order_status IN ('Delivered','Shipped');

-- Q21. Display customers from Delhi, Mumbai, or Pune.
SELECT * FROM customers WHERE city IN ('Delhi','Mumbai','Pune');

-- Q22. Find the total number of customers.
SELECT COUNT(*) FROM customers;

-- Q23. Find the average product price.
SELECT ROUND(AVG(price),2) AS Average_Price FROM products;

-- Q24. Find the highest and lowest product prices.
SELECT MAX(price) AS Highest_Price, MIN(price) AS Lowest_Price FROM products;

-- Q25. Calculate the total revenue from all orders.
SELECT ROUND(SUM(total_amount),2) AS Total_Revenue FROM orders;
