-- Create database
CREATE DATABASE IF NOT EXISTS librarydb;
-- activate database
USE librarydb;
-- Create Books table
CREATE TABLE books (
 book_id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(255) NOT NULL,
 author VARCHAR(255) NOT NULL,
 publication_year INT,
 category VARCHAR(50) NOT NULL
);
-- Create Borrowers table
CREATE TABLE borrowers (
 borrower_id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(255) NOT NULL,
 age_group VARCHAR(20) NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL
);
-- Create Loans table
CREATE TABLE loans (
 loan_id INT PRIMARY KEY AUTO_INCREMENT,
 book_id INT NOT NULL,
 borrower_id INT NOT NULL,
 loan_date DATE NOT NULL,
 return_date DATE DEFAULT NULL,
 FOREIGN KEY (book_id) REFERENCES books(book_id),
 FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);
-- Insert records into Books table
INSERT INTO books (title, author, publication_year, category)
VALUES ('Pride and Prejudice', 'Jane Austen', 1813, 'Fiction'),
 ('The Lord of the Rings', 'J. R. R. Tolkien', 1954, 'Fantasy'),
 ('To Kill a Mockingbird', 'Harper Lee', 1960, 'Literature'),
 ('The Hitchhiker\'s Guide to the Galaxy', 'Douglas Adams', 1979, 'Science Fiction'),
 ('The Catcher in the Rye', 'J. D. Salinger', 1951, 'Coming-of-Age'),
 ('Frankenstein', 'Mary Shelley', 1818, 'Gothic Fiction'),
 ('Animal Farm', 'George Orwell', 1945, 'Dystopian'),
 ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'American Literature'),
 ('1984', 'George Orwell', 1949, 'Dystopian'),
 ('The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 1892, 'Mystery');
-- Insert records into Borrowers table
INSERT INTO borrowers (name, age_group, email)
VALUES ('Alice Smith', 'Adults (25-64)', 'alice.smith@example.com'),
 ('Bob Johnson', 'Teens (13-19)', 'bob.johnson@example.com'),
 ('Charlie Brown', 'Children (0-12)', 'charlie.brown@example.com'),
 ('Diana Davis', 'Adults (25-64)', 'diana.davis@example.com'),
 ('Emily Evans', 'Teens (13-19)', 'emily.evans@example.com'),
 ('Frank Garcia', 'Adults (25-64)', 'frank.garcia@example.com'),
 ('Grace Hernandez', 'Children (0-12)', 'grace.hernandez@example.com'),
 ('Isaac Jackson', 'Teens (13-19)', 'isaac.jackson@example.com'),
 ('Jessica Jones', 'Adults (25-64)', 'jessica.jones@example.com'),
 ('Kevin Kim', 'Children (0-12)', 'kevin.kim@example.com');
-- Insert records into Loans table
INSERT INTO loans (book_id, borrower_id, loan_date, return_date)
VALUES (1, 1, '2024-02-11', NULL),
 (2, 1, '2024-02-12',NULL),
 (3, 4,'2024-02-15', '2024-02-28'),
 (4, 2, '2024-02-17',NULL),
 (5, 4, '2024-02-20',NULL),
 (6, 5, '2024-02-24',NULL),
 (7,8, '2024-02-26',NULL),
 (8, 7, '2024-03-01',NULL),
 (9, 2, '2024-03-05', '2024-03-18'),
 (10, 9, '2024-03-13',NULL);
SELECT * FROM books;
SELECT * FROM borrowers;
SELECT * FROM loans;
-- TASK1
delimiter //
create procedure popularbook(in in_age varchar(100))
BEGIN
	SELECT B.title,count(*) as count_popular from books b inner join loans l inner join borrowers br
	on b.book_id=l.book_id and l.borrower_id=br.borrower_id where br.age_group=in_age group by b.title order by count_popular;
END //

CALL POPULARBOOK('TEENS (13-19)');
-- TASK2
SELECT * FROM books;
SELECT * FROM borrowers;
SELECT * FROM loans;
DELIMITER //
CREATE PROCEDURE YEAR(IN in_year INT)
BEGIN
	SELECT COUNT(loan_date) as count_loan,month(loan_date) as months from loans as l
    where year(loan_date)=in_year group by months;
END //
CALL YEAR(2024);
-- TASK3
DELIMITER //
CREATE PROCEDURE add_loan(IN book_id INT, IN borrower_id INT)
BEGIN

  DECLARE due_date DATE;
  SET due_date = DATE_ADD(CURDATE(), INTERVAL 15 DAY);

  -- Insert the new loan entry
  INSERT INTO loans (book_id, borrower_id, loan_date, return_date)
  VALUES (book_id, borrower_id, CURDATE(), due_date);
END //

call add_loan(9,5);
select * from loans;
-- task4
DELIMITER $$
create procedure update_return_date(IN in_loan_id int)
BEGIN
UPDATE LOANS SET RETURN_DATE=CURDATE() WHERE LOAN_ID=IN_LOAN_ID;
END $$
CALL update_return_date(3);
SELECT * FROM LOANS;

-- TASK5
DELIMITER //
CREATE PROCEDURE UPDATE_PERFORMANCE (IN IN_BORROWER_ID INT,IN IN_NAME VARCHAR(255),IN IN_EMAIL VARCHAR(100))
BEGIN
	UPDATE BORROWERS SET NAME=IN_NAME, EMAIL=IN_EMAIL WHERE BORROWER_ID=IN_BORROWER_ID;
END //
CALL UPDATE_PERFORMANCE(10,'SHIVASHANKAR','SHIVA@GMAIL.COM');
SELECT * FROM BORROWERS;

-- TASK6 a
DELIMITER $$
CREATE PROCEDURE sp_eligible(in in_borrower_id int, out out_overdue_count int, out out_is_eligible varchar(20))
BEGIN
select count(*) into out_overdue_count from loans where borrower_id = in_borrower_id and return_date is NULL;
if out_overdue_count > 0 then
 set out_is_eligible = 'Not Eligible';
else
 set out_is_eligible = 'Eligible'; 
end if;
END $$

-- task6 b
delimiter $$
CREATE PROCEDURE sp_borrower_eligible(in in_borrower_id int)
BEGIN
  DECLARE overdue_count int;
  DECLARE is_eligible varchar(20);

  CALL sp_eligible(in_borrower_id, @overdue_count, @is_eligible);

  SELECT CONCAT('Total count of overdue is ', @overdue_count, ' so, the borrower is ', @is_eligible) AS 'Response';
END $$
call sp_borrower_eligible(5);
