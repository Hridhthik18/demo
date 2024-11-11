show databases;
use sakila;
show tables;
-- task1
select * from customer;
select * from customer where active=0;

-- task2
select first_name,last_name,email from customer where active=0;

-- task3
select store_id from customer where active=0 order by store_id desc limit 1;
select max(store_id) from customer where active=0;

-- task4 
select * from film;
select title from film where rating='PG-13';

-- task5
select * from film;
select title,length from film where rating='pg-13' order by length desc limit 3;

-- task6
select * from film;
select title,rental_duration from film where rating='pg-13';
select max(rental_duration) from film where rating='pg-13';
select title from film where rental_duration<7;

select title,rental_duration from film where rating='pg-13' order by rental_duration asc limit 5;

-- task7
select avg(rental_rate) from film;

-- task8
select title,sum(replacement_cost) from film group by title;

-- task9
select * from film;
select *from film_category;
select * from category;

select category_id from category where name in('animation','children');
select count(category_id) from film_category where category_id in(2,3) group by category_id;
