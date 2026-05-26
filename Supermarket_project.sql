-- Create database Supermarket
CREATE DATABASE Supermarket_db;

-- Use the database

USE Supermarket_db;

-- Create customers table

CREATE TABLE Customers(
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    PRIMARY KEY (customer_id)

);

-- Create  Product table

CREATE TABLE Products(
    product_id INT AUTO_INCREMENT,
    product_name  VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Unit_price DECIMAL(10,2),
   
    PRIMARY KEY (product_id)
    
);

-- Create Sales table

CREATE TABLE Sales(
    sales_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    Quantity INT NOT NULL,
    Payment_method VARCHAR(50) NOT NULL,
    Sales_date DATE,
   
    PRIMARY KEY (sales_id),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- Insert into tables

INSERT INTO Customers(
    first_name,
    last_name,
    city)
            
VALUES  ('Afeez', 'Johnson', 'Port Harcourt'),
('Mary', 'Okafor', 'Lagos'),
('David', 'Bello', 'Abuja'),
('Grace', 'Uche', 'Port Harcourt'),
('John', 'Musa', 'Lagos'),
('Sarah', 'Ade', 'Ibadan'),
('Michael', 'Obi', 'Enugu'),
('Chioma', 'Nnaji', 'Abuja'),
('Daniel', 'Yusuf', 'Kaduna'),
('Esther', 'James', 'Lagos'),
('Samuel', 'Peters', 'Port Harcourt'),
('Ruth', 'Danjuma', 'Benin'),
('Ibrahim', 'Sule', 'Kano'),
('Blessing', 'Eze', 'Owerri'),
('Victor', 'Edet', 'Uyo'),
('Fatima', 'Lawal', 'Abuja'),
('Henry', 'Okon', 'Calabar'),
('Peace', 'Chukwu', 'Lagos'),
('Emmanuel', 'Isaac', 'Port Harcourt'),
('Joy', 'Amina', 'Jos');



INSERT INTO Products(
    product_name,
    Category,
    Unit_price)
            
VALUES
('Rice Bag 50kg', 'Food', 85000),
('iPhone 15', 'Electronics', 1200000),
('Cooking Gas', 'Utilities', 18000),
('Television 55 Inch', 'Electronics', 450000),
('Office Chair', 'Furniture', 95000),
('Generator', 'Appliances', 350000),
('Laptop HP EliteBook', 'Electronics', 780000),
('Rice Bag 50kg', 'Food', 85000),
('Standing Fan', 'Appliances', 45000),
('Air Conditioner', 'Appliances', 520000),
('Dining Table', 'Furniture', 280000),
('Android Phone', 'Electronics', 320000),
('Rice Bag 50kg', 'Food', 85000),
('Microwave Oven', 'Appliances', 150000),
('Office Desk', 'Furniture', 120000),
('Laptop Dell Inspiron', 'Electronics', 690000),
('Freezer', 'Appliances', 410000),
('Rice Bag 50kg', 'Food', 85000),
('Smart TV 43 Inch', 'Electronics', 390000),
('Electric Kettle', 'Appliances', 25000);


INSERT INTO Sales(
    customer_id,
    product_id,
    Quantity,
    Payment_method,
    Sales_date)

VALUES
(1, 1, 2, 'Transfer', '2026-01-05'),
(2, 2, 1, 'Card', '2026-01-06'),
(3, 3, 3, 'Cash', '2026-01-07'),
(4, 4, 1, 'Transfer', '2026-01-08'),
(5, 5, 4, 'Card', '2026-01-09'),
(6, 6, 1, 'Cash', '2026-01-10'),
(7, 7, 2, 'Transfer', '2026-01-11'),
(8, 8, 1, 'Cash', '2026-01-12'),
(9, 9, 3, 'Transfer', '2026-01-13'),
(10, 10, 1, 'Card', '2026-01-14'),
(11, 11, 1, 'Transfer', '2026-01-15'),
(12, 12, 2, 'Cash', '2026-01-16'),
(13, 13, 5, 'Transfer', '2026-01-17'),
(14, 14, 1, 'Card', '2026-01-18'),
(15, 15, 2, 'Cash', '2026-01-19'),
(16, 16, 1, 'Transfer', '2026-01-20'),
(17, 17, 1, 'Card', '2026-01-21'),
(18, 18, 3, 'Cash', '2026-01-22'),
(19, 19, 2, 'Transfer', '2026-01-23'),
(20, 20, 4, 'Card', '2026-01-24');

-- Results
SELECT *
FROM Customers;

SELECT *
FROM Products;

SELECT *
FROM Sales;

-- Join the tables

SELECT
    c.first_name,
    c.last_name,
    p.product_name,
    s.Quantity,
    p.Unit_price,
    (s.Quantity * p.Unit_price) AS total_price,  -- Total price per transaction
    s.Sales_date
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
ORDER BY total_price DESC;

-- Analytics

-- 1. Total Revenue

SELECT
    SUM(s.Quantity * p.Unit_price) AS total_revenue
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id;

-- 2. Revenue by City

SELECT
    c.city,
    SUM(s.Quantity * p.Unit_price) AS revenue
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id   -- (it means from Sales table, look for where S.customer_id=c.customer_id and join the city to the sales)
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.city
ORDER BY revenue DESC;  

-- 3. Revenue by Product Category

SELECT
    p.category,
    SUM(s.quantity * p.Unit_price) AS Revenue
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    GROUP BY p.category
    ORDER BY Revenue DESC;




-- 4.TOP CUSTOMERS
 SELECT
    c.first_name,
    c.last_name,
    SUM(s.Quantity * p.Unit_price) AS total_spent
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- 5 Customer Purchase report

SELECT

    c.first_name,
    c.last_name,
    c.city,
    p.category,
    p.product_name,
    s.Quantity,
    p.Unit_price,
    (s.Quantity * p.Unit_price) AS total_price,
    s.Payment_method,
    s.Sales_date
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id;

-- 6. Payment Method Aalysis

 SELECT
    Payment_method,
    COUNT(*) AS transactions
FROM Sales
GROUP BY Payment_method
ORDER BY transactions DESC;
