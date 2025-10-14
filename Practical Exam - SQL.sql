CREATE DATABASE Exam;

USE Exam;

CREATE TABLE Author(
author_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100)
);


CREATE TABLE Books (
book_id INT PRIMARY KEY,
title VARCHAR(100),
author_id INT,
category VARCHAR(50),
isbn VARCHAR(20),
published_date DATE,
price Decimal(10,2),
available_copies INT,
FOREIGN KEY (author_id) References Author(author_id)
);

CREATE TABLE Members (
member_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
phone_number VARCHAR(15),
membership_date DATE
);

CREATE TABLE Transactions (
transaction_id INT PRIMARY KEY,
member_id INT,
book_id INT,
borrow_date DATE,
return_date DATE,
fine_amount DECIMAL(10,2),
FOREIGN KEY (member_id) REFERENCES Members(member_id),
FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


INSERT INTO Author VALUES
(1, 'J.K. Rowling', 'jk@gmail.com'),
(2, 'Chetan Bhagat', 'chetan@gmail.com'),
(3, 'APJ Abdul Kalam', 'apj@gmail.com'),
(4, 'James Clear', 'james.clear@gmail.com');

INSERT INTO Books VALUES
(1, 'Harry Potter', 1, 'Fiction', 'HP123', '2010-07-21', 650.00, 10),
(2, 'Half Girlfriend', 2, 'Romance', 'HG456', '2014-05-15', 450.00, 6),
(3, 'Wings of Fire', 3, 'Biography', 'WF789', '2005-01-10', 300.00, 5),
(4, 'Science Basics', 3, 'Science', 'SB111', '2018-02-20', 250.00, 8),
(5, 'Magic World', 1, 'Fiction', 'MW222', '2022-03-11', 700.00, 4),
(6, 'Atomic Habits', 4, 'Self Help', 'AH999', '2018-10-16', 500.00, 9);


INSERT INTO Members VALUES
(1, 'Riya Patel', 'riya@gmail.com', '9876543210', '2022-04-10'),
(2, 'Arjun Mehta', 'arjun@gmail.com', '9876500011', '2023-02-11'),
(3, 'Nisha Shah', 'nisha@gmail.com', '9845123456', '2021-08-21'),
(4, 'Karan Joshi', 'karan@gmail.com', '9898123456', '2024-01-15'),
(5, 'Priya Desai', 'priya@gmail.com', '9823456789', '2023-09-30');


INSERT INTO Transactions VALUES
(1, 1, 1, '2024-04-01', '2024-04-10', 0.00),  
(2, 2, 3, '2024-05-05', '2024-05-12', 10.00),  
(3, 1, 2, '2024-08-02', NULL, 0.00),           
(4, 3, 4, '2024-06-01', '2024-06-07', 5.00),   
(5, 2, 5, '2025-01-10', '2025-01-17', 0.00);


INSERT INTO Author VALUES
(5, 'Robin Sharma', 'robin.sharma@gmail.com');

INSERT INTO Books VALUES
(7, 'The Monk Who Sold His Ferrari', 5, 'Motivation', 'MSF555', '2003-01-01', 550.00, 6);

INSERT INTO Members Values 
(6, 'Aarav Patel', 'aarav@gmail.com', '9898776655', '2025-02-05');

Update Books SET available_copies = available_copies - 1 WHERE book_id = 1;

DELETE FROM Members m
WHERE NOT EXISTS (
    SELECT 1
    FROM Transactions t
    WHERE t.member_id = m.member_id
      AND t.borrow_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

DELETE FROM Members WHERE member_id NOT IN (SELECT DISTINCT member_id FROM Transactions);

Select * From Books;


SELECT * FROM Books WHERE published_date > '2015-01-01';

SELECT * FROM Books ORDER BY price DESC LIMIT 5;

SELECT * FROM Members WHERE membership_date > '2022-01-01';


SELECT * FROM Books WHERE category = 'Science' AND price < 500;

SELECT * FROM Books WHERE NOT available_copies > 0;

SELECT name FROM Members WHERE membership_date > '2020-01-01'
OR member_id IN (SELECT member_id FROM Transactions GROUP BY member_id HAVING COUNT(book_id) > 3);


SELECT * FROM Books ORDER BY title ASC;

SELECT member_id, COUNT(book_id) AS total_borrowed FROM Transactions GROUP BY member_id;

SELECT category, COUNT(*) AS total_books FROM Books GROUP BY category;


SELECT category, COUNT(*) AS total_books
From Books GROUP BY category;

SELECT AVG(price) AS avg_price From Books;

SELECT book_id, COUNT(book_id) AS borrow_count
From Transactions
GROUP BY book_id ORDER BY borrow_count DESC LIMIT 1;

SELECT SUM(fine_amount) AS total_fine
From Transactions;


SELECT b.title, a.name AS author_name From Books b INNER JOIN Author a ON b.author_id = a.author_id;

SELECT m.name, b.title From Members m LEFT JOIN Transactions t ON m.member_id = t.member_id
LEFT JOIN Books b ON t.book_id = b.book_id WHERE t.book_id IS NOT NULL;

SELECT b.title From Books b LEFT JOIN Transactions t ON b.book_id = t.book_id WHERE t.book_id IS NULL;

SELECT m.name From Members m LEFT JOIN Transactions t ON m.member_id = t.member_id WHERE t.member_id IS NULL;


SELECT title From Books WHERE book_id IN (SELECT book_id From Transactions WHERE member_id IN (
SELECT member_id From Members WHERE membership_date > '2022-01-01') 
);

SELECT title From Books WHERE book_id = (SELECT book_id From Transactions GROUP BY book_id
ORDER BY COUNT(book_id) DESC LIMIT 1);

SELECT name From Members WHERE member_id NOT IN (
SELECT DISTINCT member_id From Transactions);



SELECT title, YEAR(published_date) AS publication_year FROM Books;

SELECT transaction_id, DATEDIFF(return_date, borrow_date) AS days_borrowed FROM Transactions;

SELECT DATE_FORMAT(borrow_date, '%d-%m-%Y') AS borrow_date_formatted FROM Transactions;



SELECT UPPER(title) AS book_title FROM Books;

SELECT TRIM(name) AS clean_name FROM Author;

SELECT IFNULL(email, 'Not Provided') AS updated_email FROM Author;


SELECT b.title, COUNT(t.book_id) AS borrow_count,
RANK() OVER (ORDER BY COUNT(t.book_id) DESC) AS rank_no From Books b JOIN Transactions t ON b.book_id = t.book_id
GROUP BY b.title;

SELECT m.name, COUNT(t.book_id) AS total_borrowed,
SUM(COUNT(t.book_id)) OVER (ORDER BY m.name) AS cumulative_borrow
From Members m JOIN Transactions t ON m.member_id = t.member_id GROUP BY m.name;

SELECT MONTH(borrow_date) AS month,
COUNT(*) AS books_borrowed,
AVG(COUNT(*)) OVER (ORDER BY MONTH(borrow_date) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_last_3_months
From Transactions GROUP BY MONTH(borrow_date) ORDER BY month;



SELECT m.name,
CASE
	WHEN m.member_id IN (
        SELECT member_id FROM Transactions
        WHERE borrow_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    ) THEN 'Active'
    ELSE 'Inactive'
END AS Membership_Status
FROM Members m;


SELECT title,
CASE
    WHEN published_date > '2020-01-01' THEN 'New Arrival'
    WHEN published_date < '2000-01-01' THEN 'Classic'
    ELSE 'Regular'
END AS Category_Type
FROM Books;






