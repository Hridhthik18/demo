-- Create database
CREATE DATABASE IF NOT EXISTS ecommerceinvdb;
-- activate database
USE ecommerceinvdb;
-- Create Products table
CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
description TEXT,
price DECIMAL(10,2) NOT NULL,
stock_level INT NOT NULL DEFAULT 0
);
CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email_id VARCHAR(100) NOT NULL UNIQUE -- Ensures unique email addresses
);
CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'placed', -- ('placed', 'shipped', 'cancelled', 'returned')
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Assuming a customers table exists
);
CREATE TABLE order_items (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO products (name, description, price, stock_level)
VALUES ('Wireless Headphones', 'Noise-cancelling headphones with superior sound quality', 199.99, 20),
('Smartwatch', 'Fitness tracker with heart rate monitoring and GPS', 249.95, 30),
('Laptop Backpack', 'Durable backpack with padded compartments for laptops and tablets', 49.99, 50),
('Wireless Keyboard & Mouse Combo', 'Sleek and ergonomic wireless keyboard and mouse set', 39.99, 15),
('Portable Charger', 'High-capacity power bank for on-the-go device charging', 29.99, 40),
('Gaming Headset', 'Immersive audio experience for enhanced gaming', 99.99, 10),
('Action Camera', 'Compact and rugged camera for capturing all your adventures', 179.99, 25),
('Wireless Earbuds', 'True wireless earbuds with long battery life and crystal clear sound', 79.99, 60),
('Bluetooth Speaker', 'Portable speaker with powerful sound for any occasion', 59.99, 80),
('Smart Home Speaker', 'Voice-controlled speaker for managing smart home devices', 149.99, 15);
INSERT INTO customers (first_name, last_name, email_id)
VALUES ('Alice', 'Smith', 'alice.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com'),
('Diana', 'Davis', 'diana.davis@example.com'),
('Emily', 'Evans', 'emily.evans@example.com'),
('Frank', 'Garcia', 'frank.garcia@example.com'),
('Grace', 'Hernandez', 'grace.hernandez@example.com'),
('Isaac', 'Jackson', 'isaac.jackson@example.com'),
('Jessica', 'Jones', 'jessica.jones@example.com'),
('Kevin', 'Kim', 'kevin.kim@example.com');
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2024-02-16', 'placed'),
(2, '2024-02-17', 'shipped'),
(2, '2024-02-18','placed'),
(4, '2024-02-24','canceled'),
(3, '2024-02-25','returned'),
(6, '2024-03-11','canceled'),
(5, '2024-03-12','returned'),
(7, '2024-03-14','placed'),
(8, '2024-03-15','shipped'),
(10, '2024-03-18','placed');
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 2, 1),
(2, 1, 2),
(2, 3, 1),
(7, 4, 3),
(8, 7, 2),
(7, 8, 1),
(8, 5, 1),
(8, 9, 2),
(10, 6, 1);

DELIMITER $$
CREATE TRIGGER  `UPDATE_STOCK_LEVEL`
AFTER INSERT ON  `order_items`
FOR EACH ROW
BEGIN
UPDATE products
set stock_level=stock_level-new.quantity 
where product_id=new.product_id;
END;$$

select * from products;
select * from customers;
select * from order_items;
select * from orders;
desc customers;
desc order_items;
desc orders;
select * from orders;

insert into customers(first_name,last_name,email_id) values('william','david','wdavid@gmail.com');
insert into order_items(order_id,product_id,quantity) values(11,1,2);
insert into orders(customer_id,order_date,status) values(11,'2020-03-15','pending');
UPDATE orders
SET order_date = '2022-03-15'
WHERE order_id = 11;

insert into order_items(order_id,product_id,quantity) values(11,2,1);
-- demo 8.2
DELIMITER $$
create trigger `check_order_quantity`
BEFORE UPDATE ON `order_items`
FOR EACH ROW 
BEGIN 
declare available_stock int;
select stock_level into available_stock
from products
where product_id = new.product_id;
if new.quantity > available_stock Then
signal sqlstate '45000' set message_text = 'order quantity exceeds from available stock';
End if; 
END; $$
drop trigger `check_order_quantity`;

update order_items set PRODUCT_ID=2,QUANTITY=100 where ORDER_ITEM_ID=3 ;
UPDATE order_items
SET quantity = 1000 -- assuming 1000 exceeds available stock
WHERE product_id = 1; -- assuming product_id 1 has less stock



-- demo 8.3
DELIMITER $$
USE `ecommerceinvdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ecommerceinvdb`.`check_order_items_before_delete` BEFORE DELETE ON `orders` FOR EACH ROW
BEGIN
DECLARE has_items int ;
select count(*) into has_items from order_items where order_id=old.order_id;
if has_items>0 then
signal sqlstate '43000' set message_text='cannot delete order with the existing order'; 
end if;

END$$
DELIMITER ;

delete from orders where order_id=1;
select * from orders;

