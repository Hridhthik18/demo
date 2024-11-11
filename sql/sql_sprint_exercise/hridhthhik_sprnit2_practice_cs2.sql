show databases;
use techmac_db;
show tables;
select * from techhyve_employees;
select * from techcloud_employees;
select * from techsoft_employees;
-- task1:
desc  techhyve_employees;
drop table techhyve_employees;
drop table techcloud_employees;
drop table techsoft_employees;


create table techhyve_employees(
employee_id varchar(10) primary key,
first_name varchar(50) ,
last_name varchar(50) ,
gender varchar(10),
age int);

create table techcloud_employees(
employee_id varchar(10) primary key,
first_name varchar(50) ,
last_name varchar(50) ,
gender varchar(10),
age int);

create table techsoft_employees(
employee_id varchar(10) primary key,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
age int );

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

-- task1
desc techhyve_employees;
desc techcloud_employees;
desc techsoft_employees;

alter table techcloud_employees modify column first_name varchar(50) not null;
alter table techhyve_employees modify column first_name varchar(50) not null;
alter table techhyve_employees modify column last_name varchar(50) not null;

alter table techcloud_employees modify column first_name varchar(50) not null;
alter table techcloud_employees modify column last_name varchar(50) not null;

alter table techsoft_employees modify column first_name varchar(50) not null;
alter table techsoft_employees modify column last_name varchar(50) not null;
-- task1.2
alter table techhyve_employees modify column age int not null default 21;
alter table techcloud_employees modify column age int not null default 21;
alter table techsoft_employees modify column age int not null default 21;

-- task1.3
alter table techhyve_employees add constraint techhyve_employees_chk check(age>=21 and age<=55);
alter table techcloud_employees add constraint techcloud_employees_chk check(age>=21 and age<=55);
alter table techsoft_employees add constraint techsoft_employees_chk check(age>=21 and age<=55);

-- task1.4

alter table techhyve_employees 
add column user_name varchar(50) not null,
add column password varchar(50) not null;

alter table techcloud_employees 
add column user_name varchar(50) not null,
add column password varchar(50) not null;

alter table techsoft_employees 
add column user_name varchar(50) not null,
add column password varchar(50) not null;

-- doubt alter table techhyve_employees add unique(user_name);

 -- task1.5
 alter table techhyve_employees add constraint chk check(gender in("male","female")); 
 alter table techcloud_employees add constraint chk1 check(gender in("male","female")); 
 alter table techsoft_employees add constraint chk2 check(gender in("male","female")); 
	
-- task2

alter table techhyve_employees add column communication_Proficiency int default 1;
alter table techcloud_employees add column communication_Proficiency int default 1;
alter table techsoft_employees add column communication_Proficiency int default 1;
desc techhyve_employees;
desc techcloud_employees;
desc techsoft_employees;

alter table techhyve_employees add constraint check_chk check(communication_Proficiency>=1 and communication_Proficiency<=5);

-- task3:
select * from techhyve_employees;
select * from  techsoft_employees;
create table techhyvecloud_employees(select * from techhyve_employees union all select * from techsoft_employees); 
select * from techhyvecloud_employees;
