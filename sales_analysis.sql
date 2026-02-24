-- Crear la base de datos 
CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis; 
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items, orders, products, customers;
SET FOREIGN_KEY_CHECKS = 1;

-- Tabla de clientes 
CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    email VARCHAR(100), 
    city VARCHAR(50), 
    country VARCHAR(50), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
); 

-- Tabla de productos
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100), 
	category VARCHAR(50), 
    price DECIMAL(10,2), 
    stock INT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

-- Tabla de pedidos
CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY, 
    customer_id INT, 
    order_date DATE, 
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending', 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);  

-- Tabla de detalles de pedido 
CREATE TABLE order_items (
	order_item_id INT AUTO_INCREMENT PRIMARY KEY, 
    order_id INT, 
    product_id INT, 
    quantity INT, 
    price DECIMAL(10,2), 
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id)
); 

-- Insertar algunos clientes de ejemplo
INSERT INTO customers (first_name, last_name, email, city, country) VALUES 
('John', 'Doe', 'john.doe@example.com', 'London', 'UK'), 
('Jane', 'Smith', 'jane.smith@example.com', 'Manchester', 'UK'), 
('Alice', 'Johnson', 'alice.johnson@example.com', 'Birmingham', 'UK');

-- Insertar productos de ejemplo
INSERT INTO products (name, category, price, stock) VALUES
('Laptop', 'Electronics', 1200.00, 10), 
('Smartphone', 'Electronics', 800.00, 15), 
('Desk Chair', 'Furniture', 150.00, 20), 
('Notebook', 'Stationery', 5.00, 100);

-- Insertar pediddos de ejemplos
INSERT INTO orders (customer_id, order_date, status) VALUES 
(1, '2026-01-15','Delivered'), 
(2, '2026-02-01', 'Shipped'), 
(1, '2026-02-01', 'Pending'); 

-- Insertar items de pedido 
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES 
(1, 1, 1, 1200.00), 
(1, 4, 5, 5.00), 
(2, 2, 2, 800.00), 
(3, 3, 1, 150.00); 