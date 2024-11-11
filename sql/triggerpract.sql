show databases;
use db;
show tables;
create database trigger_pract;
use trigger_pract;

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
desc employee;
select * from employee_log;
-- set rules before the insert 
create trigger `before_insert_employee`
before insert on `employee`
for each row
	set new.name=upper(new.name);
    
    
    
insert into employee(name, position, salary, contact) values("hridhthik","Gm",50000,63);
select * from employee;
select * from employee_log;


create trigger `reflectvalues`
before insert on `employee`
for each row
	insert into employee_log (employee_id,prev_employee_name,emp_salary) values(new.id,new.name,new.salary);
set sql_safe_updates=0;
insert into employee(name, position, salary, contact) values("sriram","Gm",40000,73);
delete from employee where name='sriram';
drop trigger reflectvalues;

create trigger `updatetrigger`
after update on `employee`
for each row
	insert into employee_log(employee_id,prev_employee_name,emp_salary) values(new.id,new.name,new.salary);
    
update employee set salary=9000 where name='hridhthik';

select * from employee;
delimiter $$
create trigger `beforeupdate`
before update on `employee`
for each row
begin
	if new.position='sale' then
    set new.salary=new.salary+1000;
    end if;
end; $$
drop trigger `beforeupdate`;
insert into employee(id,name,position,salary,contact) values(100,'xxx','sale',6000,42);

update employee set position='sale' where position='sale';
insert into employee(id,name,position,salary,contact) values(101,'yyy','sale',7000,52);

select * from employee;
delimiter $$
create trigger `befor-delete`
before delete on `employee`
for each row
begin 
	if old.position='sale' then
    signal sqlstate '43000' set message_text='you cannot delete the gm';
    end if;
end;$$
drop trigger`befor-delete`;

delete from employee where position ='sale';
rollback;