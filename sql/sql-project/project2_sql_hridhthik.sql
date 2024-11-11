USE `modelcarsdb`;
-- task1:employee data analysis
-- task1.1:
select count(*) as total_no_of_employees from employees;
/*interpretation:
 This SQL query counts the total number of records (employees) in the employees table.*/

-- task1.2:
select employeeNumber,concat(firstName,' ',lastName) as full_name_of_employee,email,jobTitle from employees;
/*interpretation:
Retrieves each employee's ID, full name, email, and job title from the employees table.*/

-- task1.3:
select * from employees;
select count(*) as number_of_employees,jobTitle from employees group by jobTitle order by number_of_employees desc;
/*interpretation:
This query counts the number of employees for each job title in the employees table. 
It groups the employees by their job titles and then displays the count of employees for each title, ordered from the highest to the lowest number of employees.
The result helps to understand how many employees hold each job title and which job titles are more or less common within the organization.*/

-- task1.4:
select firstName,lastName,reportsTo from employees where reportsTo is null;
/*interpretation:
This query retrieves the first and last names of employees who do not report to anyone, meaning their reportsTo field is NULL. 
These are typically the top-level employees or managers who do not have a supervisor.*/

-- task1.5
select sum(od.quantityOrdered*priceEach) as totalsales,c.SalesRepEmployeeNumber from orderdetails od join orders o join customers c
on od.orderNumber=o.orderNumber and o.customerNumber=c.customerNumber group by c.SalesRepEmployeeNumber;
/*interpretation:
This query calculates the total sales made by each sales representative. 
It sums the product of quantityOrdered and priceEach from the orderdetails table for each order and groups the results by SalesRepEmployeeNumber, which identifies the sales representative responsible for each customer. 
The result shows the total sales amount each sales representative has generated based on the orders placed by their customers.*/

-- task1.6
select c.SalesRepEmployeeNumber,sum(od.quantityOrdered*od.priceEach) as totalsales from orderdetails od join orders o join customers c
on od.orderNumber=o.orderNumber and o.customerNumber=c.customerNumber group by c.SalesRepEmployeeNumber order by totalsales desc;
/*interpretation:
This query sums the total sales for each sales representative by multiplying quantityOrdered by priceEach from the orderdetails table. 
It groups the results by SalesRepEmployeeNumber and orders them in descending order of total sales.
This allows for easy identification of the highest-performing sales representatives.*/

-- task1.7
select * from employees;
select * from orderdetails;
select concat(e.firstName,' ',e.lastName) as emp_fullName,sum(quantityOrdered*priceEach) as totalsales,avg(quantityOrdered*priceEach) as avgsales,e.officecode from 
employees e join customers c join orders o join orderdetails od 
on e.employeeNumber=c.salesRepEmployeeNumber and c.customerNumber=o.customerNumber and o.orderNumber=od.orderNumber group by emp_fullName,e.officecode
having totalsales>avgsales order by totalsales desc;

/*interpretation:
This query calculates the total and average sales for each employee by summing and averaging the product of quantityOrdered and priceEach.
It groups the results by the employee's full name and filters to include only those employees whose total sales exceed their average sales. 
This identifies high-performing employees in terms of sales.*/

-- task2:order analysis
-- task2.1:
select c.customerNumber,avg(quantityOrdered*priceEach) as average_order_amount from customers c join orders o join orderdetails od
on c.customerNumber=o.customerNumber and o.orderNumber=od.orderNumber group by c.customerNumber order by average_order_amount desc;
/*interpretation:
	This query computes the average order amount for each customer by multiplying quantityOrdered by priceEach. 
It joins the customers, orders, and orderdetails tables, grouping the results by customerNumber to provide insights into customer spending patterns.*/

-- task2.2:
select month(orderdate) as month_of_order,monthname(orderdate) as name_of_the_month,count(*) as number_of_orders_placed from orders group by month_of_order,name_of_the_month;
/*interpretation:
This query counts the number of orders placed each month by extracting the month number and name from the orderdate. 
It groups the results by both the month number and month name, providing a summary of orders per month, which helps analyze seasonal trends in order placement.*/

-- task2.3:
select * from orders;
select orderNumber,status from orders where status='pending'; 
select orderNumber,status from orders where status='in process'; 
/*interpretation:
These queries retrieve order numbers and statuses for orders that are either 'pending' or 'in process,' allowing for the monitoring of orders awaiting action versus those actively being processed.*/

-- task2.4:
select * from customers;
select * from orders;
select o.orderNumber,c.customerNumber,c.customerName,c.phone,c.city,c.state,c.country,c.postalcode,c.creditLimit from orders o join customers c on o.customerNumber=c.customerNumber; 
/*interpretation:
This query retrieves order numbers and related customer details, such as name, phone, city, state, country, postal code, and credit limit, by joining the orders and customers tables. 
It provides a comprehensive overview of customers associated with each order.*/

-- task2.5:
select orderNumber,orderDate from orders order by orderDate desc;
/*interpretation:
This query retrieves order numbers and their corresponding order dates from the orders table, sorting the results in descending order by the order date. 
This allows you to see the most recent orders at the top of the list.*/

-- task2.6:
select o.orderNumber,sum(quantityOrdered*priceEach) as total_sales from orders o join orderdetails od
on o.orderNumber=od.orderNumber group by o.orderNumber order by total_sales desc;
/*interpretation:
This query calculates the total sales for each order by summing the product of quantityOrdered and priceEach, grouping the results by orderNumber. 
It provides the total sales amount associated with each individual order.*/

-- task2.7:
select o.orderNumber,sum(quantityOrdered*priceEach) as total_sales from orders o join orderdetails od
on o.orderNumber=od.orderNumber group by o.orderNumber order by total_sales desc limit 1;
/*interpretation:
This query retrieves the order number and total sales for each order, sorting by total sales in descending order and limiting the result to the highest-selling order.*/

-- task2.8:
select o.orderNumber,od.productCode,od.quantityOrdered,od.priceEach,od.orderLineNumber from orders o join orderdetails od
on o.orderNumber=od.orderNumber group by o.orderNumber,od.productCode,od.quantityOrdered,od.priceEach,od.orderLineNumber;
		-- or
select * from orders natural join orderdetails;
/*interpretation:
This query retrieves detailed information about each order, including order number, product code, quantity ordered, price per item, and line number, grouping by these fields to ensure unique entries for each order line.*/

-- task2.9:
select p.productName,count(od.orderNumber) as frequent_order_products from orderdetails od join products p
on od.productCode=p.productCode group by p.productName order by frequent_order_products desc;
/*interpretation:

This query counts the number of orders for each product, listing product names alongside their order counts,
 and sorts the results in descending order to highlight the most frequently ordered products*/

-- task2.10:
select o.orderNumber,sum(quantityOrdered*priceEach) as total_revenue from orders o join orderdetails od
on o.orderNumber=od.orderNumber group by o.orderNumber order by total_revenue desc; 
/*interpretation:
This query calculates the total revenue for each order by summing the product of quantityOrdered and priceEach, grouping the results by orderNumber to show the total revenue for each order.*/

-- task2.11:
select orderNumber,sum(quantityOrdered*priceEach) as total_revenue from orderdetails group by orderNumber order by total_revenue desc limit 10;
/*interpretation:
This query retrieves the top 10 orders with the highest total revenue by summing quantityOrdered and priceEach, 
grouping by orderNumber and sorting in descending order of revenue.*/

-- task2.12:
select * from products;
select od.orderNumber,p.productCode,p.productName,p.productLine,p.productScale,p.productVendor,p.productDescription,p.quantityInStock,p.buyPrice,p.MSRP from orderdetails od left join products p
on od.productCode=p.productCode;
/*interpretation:

This query retrieves comprehensive product details for each order, including order number and various product attributes, 
using a left join to ensure all order details are included even if some products lack corresponding entries in the products table.*/

-- task2.13
select * from orders;
select orderNumber from orders where shippedDate > requiredDate;
/*interpretation:

This query retrieves order numbers for orders that were shipped later than their required delivery dates, highlighting instances of shipping delays.*/

-- task2.14:
select * from products;
select od1.productcode as p1,od2.productcode as p2
FROM orderdetails AS od1
JOIN orderdetails AS od2 ON od1.orderNumber = od2.orderNumber 
where od1.productCode < od2.productCode;
/*interpretation
/* interpretation
The query produces a list of pairs of product codes (p1, p2) that were ordered together in the same order, 
with the condition that p1 is always less than p2 to avoid duplicates.*/


-- task2.15
select * from orderdetails;
select orderNumber,sum(quantityOrdered*priceEach) as total_revenue from orderdetails group by orderNumber;
/*interpretation
This query identifies the 10 highest-revenue orders, showing the order number and the corresponding total revenue for each.*/


-- task2.16
DELIMITER $$
CREATE TRIGGER `update_credit_limit_after_order`
AFTER INSERT ON `orders`
FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(10,2);
    DECLARE new_creditLimit decimal(10,2);
    -- Calculate the total amount of the order
    SELECT SUM(od.quantityOrdered * od.priceEach) INTO order_total
    FROM orderdetails od
    WHERE od.orderNumber = NEW.orderNumber;

    
    SET new_creditLimit = (SELECT creditLimit FROM CUSTOMERS WHERE customerNumber = NEW.customerNumber) -order_total;
    update customers set creditLimit=new_creditLimit where customerNumber = NEW.customerNumber;

END; $$

-- or

DELIMITER $$
CREATE TRIGGER `update_credit_limit_after_order`
AFTER INSERT ON `orders`
FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(10,2);
    -- Calculate the total amount of the order
    SELECT SUM(od.quantityOrdered * od.priceEach) INTO order_total
    FROM orderdetails od
    WHERE od.orderNumber = NEW.orderNumber;

    -- Update the customer's credit limit by subtracting the order total
    UPDATE customers
    SET creditLimit = creditLimit - order_total
    WHERE customerNumber = NEW.customerNumber;
END; $$

DROP TRIGGER `update_credit_limit_after_order`;
select * from customers;
update customers set creditLimit=21000 where customerNumber=103;
update customers set creditLimit=71800.00 where customerNumber=112;

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (4, 'S18_1749', 30, 136.00, 1),
       (4, 'S18_2248', 50, 55.00, 2);
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, customerNumber)
VALUES (4, '2024-09-27', '2024-10-05', NULL, 'In Process', 103);

SELECT creditLimit FROM customers WHERE customerNumber = 112;

select * from orderdetails;
select * from orders;

-- task2.17
select * from orderdetails;
select * from orders;
CREATE TABLE product_quantity_log (
    
    productCode VARCHAR(20),
    quantity_changed INT,
    action varchar(10),
    orderdate date
);
drop table product_quantity_log ;
DELIMITER $$
CREATE TRIGGER TR_Orderdetails_QuantityChange
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
declare action varchar(10);
set action=if (new.quantityordered>quantityordered,"increased","decreased");

INSERT INTO product_quantity_log (productCode,quantity_changed,action,orderdate )
VALUES (NEW.productCode, new.quantityOrdered-quantityOrdered,action,curdate());
END; $$
drop trigger TR_Orderdetails_QuantityChange;
desc orderdetails;
select * from orderdetails;
select * from orders;
set sql_safe_updates=0;
insert into orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber) value(2,'2024-10-02','2024-10-05',null,'pending',null,103);
insert into orderdetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) values(2, 'S17_1750',100 , 50.00, 2);
select * from orderdetails;
select * from orders;
