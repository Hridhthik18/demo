create database test;
use test;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(100)
);
CREATE TABLE CityCustomerCount (
    City VARCHAR(100) PRIMARY KEY,
    CustomerCount INT DEFAULT 0
);
CREATE TABLE Bonuses (
    EmployeeID INT PRIMARY KEY,
    BonusAmount DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
    (1, 'Marketing'),
    (2, 'Sales'),
    (3, 'Finance'),
    (4, 'Human Resources');
    
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES 
    (101, 'John', 'Doe', 1, 55000.00),
    (102, 'Jane', 'Smith', 2, 48000.00),
    (103, 'Alice', 'Johnson', 1, 62000.00),
    (104, 'Robert', 'Brown', 3, 51000.00),
    (105, 'Emily', 'Davis', 4, 45000.00);

INSERT INTO Customers (CustomerID, CustomerName, City)
VALUES 
    (201, 'CustomerA', 'New York'),
    (202, 'CustomerB', 'Los Angeles'),
    (203, 'CustomerC', 'New York'),
    (204, 'CustomerD', 'Chicago'),
    (205, 'CustomerE', 'Los Angeles');
INSERT INTO CityCustomerCount (City, CustomerCount)
VALUES 
    ('New York', 2),
    ('Los Angeles', 2),
    ('Chicago', 1);
INSERT INTO Bonuses (EmployeeID, BonusAmount)
VALUES 
    (101, 3000.00),
    (102, 2500.00),
    (103, 3500.00),
    (104, 2800.00),
    (105, 2200.00);

-- 1. Query to Get Department Names and Corresponding Number of Employees in Each Department 
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- 2. Query to Get the Last Names of All Employees in the Marketing Department
SELECT e.LastName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';

-- 3. Query to Get First Names of All Employees with a Salary Greater Than $50,000 
SELECT FirstName
FROM Employees
WHERE Salary > 50000;

-- 4. Trigger to Update Customer Count by City
-- Trigger to update count on new customer insert
DELIMITER //

CREATE TRIGGER UpdateCityCountAfterInsert
AFTER INSERT ON Customers
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT * FROM CityCustomerCount WHERE City = NEW.City) THEN
        UPDATE CityCustomerCount
        SET CustomerCount = CustomerCount + 1
        WHERE City = NEW.City;
    ELSE
        INSERT INTO CityCustomerCount (City, CustomerCount)
        VALUES (NEW.City, 1);
    END IF;
END;
//

DELIMITER ;


-- Trigger to update count on customer city update
DELIMITER //

CREATE TRIGGER `UpdateCityCountAfterUpdate`
AFTER UPDATE ON `Customers`
FOR EACH ROW
BEGIN
    IF OLD.City <> NEW.City THEN
        -- Decrement count in old city
        UPDATE CityCustomerCount
        SET CustomerCount = CustomerCount - 1
        WHERE City = OLD.City;

        -- Increment count in new city
        IF EXISTS (SELECT * FROM CityCustomerCount WHERE City = NEW.City) THEN
            UPDATE CityCustomerCount
            SET CustomerCount = CustomerCount + 1
            WHERE City = NEW.City;
        ELSE
            INSERT INTO CityCustomerCount (City, CustomerCount)
            VALUES (NEW.City, 1);
        END IF;
    END IF;
END;
//

DELIMITER ;


-- 5. Query to Get Employees and Their Corresponding Departments
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Q4-CHECKING OUTPUT
INSERT INTO Customers (CustomerID, CustomerName, City) 
VALUES (206, 'CustomerF', 'New York');
SELECT * FROM CityCustomerCount;

UPDATE Customers 
SET City = 'Los Angeles' 
WHERE CustomerID = 201;
SELECT * FROM CityCustomerCount;

