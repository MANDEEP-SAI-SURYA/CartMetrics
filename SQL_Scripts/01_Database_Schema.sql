CREATE DATABASE shopsphere;
USE shopsphere;

-- 1 Customer Table
CREATE TABLE Customers(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL,
    customer_type ENUM('Regular','Premium') DEFAULT 'Regular'
);

-- 2 Categories Table
CREATE TABLE categories(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(255)
);

-- 3 Sellers Table
CREATE TABLE sellers(
    seller_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    company_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50),
    state VARCHAR(50),
    joining_date DATE,
    seller_rating DECIMAL(2,1)
);

-- 4 Products Table
CREATE TABLE products(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    seller_id INT NOT NULL,
    brand VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0,
    launch_date DATE,

    FOREIGN KEY(category_id)
        REFERENCES categories(category_id),

    FOREIGN KEY(seller_id)
        REFERENCES sellers(seller_id)
);

-- 5 Orders Table
CREATE TABLE orders(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
);

-- 6 Order_Items Table
CREATE TABLE order_items(
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY(order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

-- 7 Payments Table
CREATE TABLE payments(
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_date DATE,
    payment_method ENUM('UPI','Credit Card','Debit Card','Net Banking','COD'),
    payment_status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',

    FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- 8 Shipping Table
CREATE TABLE shipping(
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    shipping_date DATE,
    delivery_date DATE,
    courier_name VARCHAR(100),
    shipping_status ENUM('Pending','In Transit','Delivered'),

    FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- 9 Reviews Table
CREATE TABLE reviews(
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,

    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

-- 10 Inventory Table
CREATE TABLE inventory(
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNIQUE NOT NULL,
    stock_available INT NOT NULL,
    reorder_level INT NOT NULL,
    warehouse_location VARCHAR(100),
    last_updated DATE,

    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);