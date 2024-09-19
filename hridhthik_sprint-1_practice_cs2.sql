-- task1: create a database
create database techmac_db;
use techmac_db;

-- task2:create a three table

create table techhyve_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);

create table techcloud_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);

create table techsoft_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);



-- task3: insert values for tables
insert into techhyve_employees values
('TH0001','Eli','Evans','Male',26),
('TH0002','Carlos','Simmons','Male',32),
('TH0003','Kathie','Bryant','Female',25),
('TH0004','joey','Hughes','Male',41),
('TH0005','Alice','Matthews','Female',52);

insert into techcloud_employees values
('TC0001','Teresa','Bryant','Female',39),
('TC0002','Alexis','patterson','Male',48),
('TH0003','Rose','Bell','Female',42),
('TC0004','Gemma','Watkins','Female',44),
('TC0005','kingston','Maetinez','Male',29);

insert into techhyve_employees values
('TH0001','Eli','Evans','Male',26),
('TH0002','Carlos','Simmons','Male',32),
('TH0003','Kathie','Bryant','Female',25),
('TH0004','joey','Hughes','Male',41),
('TH0005','Alice','Matthews','Female',52);


insert into techsoft_employees values
('TS0001','Peter','Burtler','Male',44),
('TS0002','Harold','Simmons','Male',54),
('TS0003','Juliana','Sanders','Female',36),
('TS0004','Paul','Ward','Male',29),
('TS0005','Nicole','Bryant','Female',30);

select * from techhyve_employees;
select * from techcloud_employees;
select * from techsoft_employees;

-- task4:create a a database of backup
create database backup_techmac_db;
use backup_techmac_db;

create table techhyve_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);

create table techcloud_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);

create table techsoft_employees(
employee_id varchar(10) primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(10) not null,
age int not null);




insert into techhyve_employees values
('TH0001','Eli','Evans','Male',26),
('TH0002','Carlos','Simmons','Male',32),
('TH0003','Kathie','Bryant','Female',25),
('TH0004','joey','Hughes','Male',41),
('TH0005','Alice','Matthews','Female',52);

insert into techcloud_employees values
('TC0001','Teresa','Bryant','Female',39),
('TC0002','Alexis','patterson','Male',48),
('TH0003','Rose','Bell','Female',42),
('TC0004','Gemma','Watkins','Female',44),
('TC0005','kingston','Maetinez','Male',29);

insert into techsoft_employees values
('TS0001','Peter','Burtler','Male',44),
('TS0002','Harold','Simmons','Male',54),
('TS0003','Juliana','Sanders','Female',36),
('TS0004','Paul','Ward','Male',29),
('TS0005','Nicole','Bryant','Female',30);

create table techhyve_employees_bkp like techhyve_employees;
create table techcloud_employees_bkp like techcloud_employees;
create table techsoft_employees_bkp like techsoft_employees;

insert techhyve_employees_bkp select * from techhyve_employees;
insert techcloud_employees_bkp select * from techcloud_employees;
insert techsoft_employees_bkp select * from techsoft_employees;

select * from techhyve_employees_bkp;
select * from techcloud_employees_bkp;
select * from techsoft_employees_bkp; 

-- task5:delete the records:
use techmac_db;
delete from techhyve_employees where employee_id='TH0003';
delete from techhyve_employees where employee_id='TH0005';

delete from techcloud_employees where employee_id='TC0001';
delete from techcloud_employees where employee_id='TC0004';

select * from techhyve_employees;
select * from techcloud_employees;