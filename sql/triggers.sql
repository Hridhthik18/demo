create database db;
use db;

-- create employees table
create table employee(id int auto_increment primary key,
name varchar(50),
position varchar(50),
salary int,
contact int default 88 );

-- create the employee log tables
create table employee_log(
log_id int auto_increment primary key,
employee_id int,
prev_employee_name varchar(50),
emp_salary int );
insert into employee(name, position, salary, contact) values ('Raj', 'Manager', 300000, 45), ('Manoj', 'PManager', 500000, 89);
select * from employee;
select * from employee_log;