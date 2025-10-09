CREATE DATABASE ProjectTwo;

USE ProjectTwo;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02');

INSERT INTO Orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75);

INSERT INTO Employees VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00);

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Orders.OrderID, Orders.TotalAmount
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerID, Customers.FirstName, Orders.OrderID, Orders.TotalAmount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Orders.OrderID, Orders.TotalAmount, Customers.FirstName, Customers.LastName
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT Customers.CustomerID, Customers.FirstName, Orders.OrderID, Orders.TotalAmount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.CustomerID, Customers.FirstName, Orders.OrderID, Orders.TotalAmount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders)
);

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT OrderID, YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month
FROM Orders;

SELECT OrderID, DATEDIFF(CURDATE(), OrderDate) AS DaysPassed
FROM Orders;

SELECT OrderID, DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
FROM Orders;

SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

SELECT REPLACE(FirstName, 'John', 'Jonathan') AS NewName
FROM Customers;

SELECT UPPER(FirstName) AS CapitalName, LOWER(LastName) AS SmallName
FROM Customers;

SELECT TRIM(Email) AS CleanEmail FROM Customers;

SELECT OrderID, TotalAmount,
SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

SELECT OrderID, TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS RankNo
FROM Orders;

SELECT OrderID, TotalAmount,
CASE
WHEN TotalAmount > 1000 THEN '10% off'
WHEN TotalAmount > 500 THEN '5% off'
ELSE 'No discount'
END AS Discount
FROM Orders;

SELECT EmployeeID, FirstName, LastName, Salary,
CASE
WHEN Salary >= 55000 THEN 'High'
WHEN Salary BETWEEN 45000 AND 54999 THEN 'Medium'
ELSE 'Low'
END AS SalaryType
FROM Employees;





