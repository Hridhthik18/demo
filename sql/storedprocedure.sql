create database STDEMO;
use  STDEMO;

create table customers(
customer_id int auto_increment primary key,
first_name varchar(100),
last_name varchar(100),
email varchar(100));

insert into customers (first_name,last_name,email) values('john','doe','john@gmail.com');

delimiter $$
create procedure sp_add_customer(in p_first_name varchar(100),in p_last_name varchar(100),in p_email varchar(100))

BEGIN
INSERT INTO customers(first_name,last_name,email) values(p_first_name,p_last_name,p_email);
END $$

call sp_add_customer('hridhthik','tp','hridhthik18@gmail.com');
select * from customers;

delimiter //
create procedure sp_display_customer()
BEGIN
SELECT * FROM CUSTOMERS;
END //

CALL sp_display_customer;
 show create procedure sp_display_customer;

delimiter //
create procedure sp_specific_record(in p_customer_id INT )
BEGIN
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID=P_CUSTOMER_ID;
END //
CALL sp_specific_record(2);


delimiter //
create procedure sp_modified_display_customer(
IN in_cus_id int,
OUT out_fname varchar(100),
OUT out_lname varchar(100),
OUT out_email varchar(100))

begin 
	select first_name,last_name,email into out_fname,out_lname,out_email
    from customers where customer_id=in_cus_id;
end //

call sp_modified_display_customer(1,@out_fname,@out_lname,@out_email);
select concat('details are :',@out_fname,' ',@out_lname,' ',@out_email) as details;
select * from customers;

drop procedure sp_display_customer;


create table product(
product_id int auto_increment primary key,
name varchar(100),
price decimal(10,3),
category varchar(100));

delimiter //
create procedure sp_add_product(IN in_name varchar(100),IN in_price decimal(10,3),IN in_category varchar(100))
BEGIN
	INSERT INTO PRODUCT(name,price,category) values(in_name,in_price,in_category) ;
END //
CALL sp_add_product('baby romper',57.9,'kidswear');
CALL SP_add_product('toy',1.9,'kidsaccessories');
select * from product;
