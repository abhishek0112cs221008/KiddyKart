CREATE DATABASE quickkart;

USE quickkart;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('admin', 'customer') DEFAULT 'customer'
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    image_url VARCHAR(255),
    description TEXT
);

select * from users;
SELECT * FROM products ORDER BY category;
UPDATE users 
SET role = 'admin' WHERE id = 1;


INSERT INTO users 
VALUES
('2','admin', 'admin@admin.com', 'ADMIN', 'admin');

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100),
    product_id INT,
    quantity INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE orders ADD payment_id VARCHAR(100);
ALTER TABLE orders ADD COLUMN status ENUM('Pending', 'Shipped', 'Delivered') DEFAULT 'Pending';

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_email VARCHAR(100),
    user_name VARCHAR(100),
    rating INT,
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100),
    full_name VARCHAR(100),
    phone VARCHAR(15),
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    country VARCHAR(50) DEFAULT 'India',
    is_default BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_email) REFERENCES users(email)
);

select * from addresses;



-- SELECT o.*, a.full_name, a.phone, a.street, a.city, a.state, a.pincode 
--         	             FROM orders o
--         	             LEFT JOIN addresses a ON a.id = ( 
--         	             SELECT id FROM addresses WHERE user_email = o.user_email ORDER BY id DESC LIMIT 1 );
-- 						