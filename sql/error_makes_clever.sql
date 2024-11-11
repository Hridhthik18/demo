create database error_makes_clever;
use error_makes_clever;
-- ddl commands
create table teacher(
name varchar(100),
age int,
department varchar(100),
salary int);

-- pract
create table student(
name varchar(100),
department varchar(100),
marks_scored int);

alter table teacher add column degree varchar(100);
-- pract
alter table student add column city varchar(100);

alter table teacher rename column department to dept;
-- pract
alter table student rename column marks_scored to marks ;

alter table teacher modify age varchar(100);

truncate student;
desc student;

drop table student;
drop table  teacher;

-- dml
create table student(
name varchar(100),
age int,
department varchar(100))

select * from student;
insert into student values('john',23,'CSE'),('praveen',45,'ECE'),('suresh',34,'EEE');
set sql_safe_updates=0;
update student set age =20 where name='john';
update student set department='compute_science' where age=20;
delete from student where age=20;
delete from student;
select * from student;
drop table student;

create table customer(
customer_id int,
customer_name varchar(100),
customer_address varchar(100),
city varchar(100),
state varchar(100),
zip_code varchar(100));

insert into customer values(1,'john doe','392 sunset blvd','newyork','nt','10059'),
(2,'mary smith','6900 main st.','san francisco','ca','94032'),
(3,'richard newman','2040 riverside rd','san diego','ca','92010'),
(4,'cathy cook','4010 speedway','tucson','az','85719');

select * from customer;

alter table customer add column mobile_number int;
alter table customer modify mobile_number varchar(100);

alter table customer rename column customer_address to address;
delete from customer where mobile_number=null;
select * from customer;

-- for deleteing null values use is instead of =
delete from customer where mobile_number is null;
select * from customer;

insert into customer values(1,'john doe','392 sunset blvd','newyork','nt','10059','555-123-4567'),
							(2,'mary smith','6900 main st.','san francisco','ca','94032','555-987-6543'),
							(3,'richard newman','2040 riverside rd','san diego','ca','92010','555-555-555'),
							(4,'cathy cook','4010 speedway','san diego','ca','85719','555-321-7890'),
							(5,'alice jhonson','123 oak street','san diego','ca','90001','555-111-2222'),
							(6,'bob williams','456 elm avenue','chicago','il','60601','555-444-7777');
select * from customer;
update customer set mobile_number='82206-1234' where customer_name='mary smith';
delete from customer where zip_code='60601';

select  customer_name  from customer where state='ca';
select * from customer where customer_id>5;

alter table customer drop column mobile_number;
select * from customer;

truncate customer;

create table  student(
student_name varchar(100),
student_mark int,
department varchar(100));

insert into student values("praveen",1,"cse"),("manoj",2,"mech"),("karthi",3,"ece"),("raju",4,"mech"),("deepak",5,"cse");
select * from student;
update student set student_mark=3 where student_name='deepak';
select sum(student_mark) as total from student;
select max(student_mark) as maximum from student;
select min(student_mark) as minimum from student;
select avg(student_mark) as average from student;
select count(*) from student;
select count(*) from student where department='cse';
select count(*),department from student group by department;

drop table student;

create table  student(
student_name varchar(100),
mark int,
department varchar(100));

insert into student values
("barath",67,"cse"),
("venkat",89,"ece"),
("praveen",23,"mech"),
("abdul",63,"cse"),
("kadhir",88,"cse"),
("john",81,"mech"),
("manoj",91,"cse"),
("mani",50,"ece");

select * from student;
select student_name,mark from student order by mark desc;
select student_name,mark from student order by mark ;
select department,avg(mark) from student group by department;
select department,count(*) as students from student group by department order by 'students';

create table employee(
employeeid int,
firstname varchar(50),
lastname varchar(50),
department varchar(50),
salary int);

insert into employee values(1,'john','doe','hr',55000),
							(2,'jane','smith','it',60000),
                            (3,'bob','johnson','it',62000),
                            (4,'alice','williams','hr',54000),
                            (5,'eva','davis','finance',58000),
                            (6,'mike','brown','finance',59000);
select * from employee order by lastname asc;
select * from employee where department='it' order by salary desc;
select count(*) as employees,department from employee group by department;

select avg(salary),department from employee group by department order by department asc;
select avg(salary),department from employee group by department order by avg(salary) desc limit 1;		 


select * from employee;
select department,avg(salary),count(*) from employee group by department;

select department,avg(salary),count(*) from employee group by department having avg(salary)>55000 and  count(*)>=2;