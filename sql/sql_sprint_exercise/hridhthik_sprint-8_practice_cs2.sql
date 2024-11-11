USE ecommerceinvdb;
SHOW TABLES;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;
-- task1
DELIMITER $$
USE `ecommerceinvdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ecommerceinvdb`.`order_items_BEFORE_INSERT` BEFORE INSERT ON `order_items` FOR EACH ROW
BEGIN
DECLARE CURRENT_STOCK INT;
SELECT stock_level into CURRENT_STOCK from products where product_id=new.product_id;

if new.quantity<=0 then 
signal sqlstate '43000' set message_text='negative or zero qty';
end if;

if new.quantity> current_stock then
signal sqlstate '43000' set message_text='insufficient stock for this product';
end if;
END$$
DELIMITER ;
 
insert into order_items(order_id,product_id,quantity) values (1,3,0);
insert into order_items(order_id,product_id,quantity) values (1,3,-1);

-- task2:
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;
alter table orders add column total_amount decimal(10,2);
update orders set total_amount=0 where order_id=1;
update orders set total_amount=0 where order_id=2;
update orders set total_amount=0 where order_id=3;
update orders set total_amount=0 where order_id=4;
update orders set total_amount=0 where order_id=5;
update orders set total_amount=0 where order_id=6;
update orders set total_amount=0 where order_id=7;
update orders set total_amount=0 where order_id=8;
update orders set total_amount=0 where order_id=9;
update orders set total_amount=0 where order_id=10;
update orders set total_amount=0 where order_id=11;

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;
select * from daily_sales;

create table if not exists daily_sales(
id int primary key auto_increment,
sale_date date,
total_sales decimal(10,2));

DELIMITER $$
USE `ecommerceinvdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ecommerceinvdb`.`order_items_AFTER_INSERT` AFTER INSERT ON `order_items` FOR EACH ROW
BEGIN
DECLARE unit_price decimal(10,2);
DECLARE amount decimal(10,2);
select price into unit_price from products where product_id=new.product_id;

update orders set total_amount=total_amount+(new.quantity*unit_price)
	where order_id=new.order_id and status='placed';

select total_amount into amount from orders where order_id=new.order_id;    
insert into daily_sales(sale_date,total_sales) values (curdate(),amount);
END$$
DELIMITER ;
drop trigger `daily_sales_AFTER_INSERT`; 

insert into order_items (order_id,product_id,quantity) values(10,1,2);


