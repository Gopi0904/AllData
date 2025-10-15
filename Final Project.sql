CREATE DATABASE University;

USE University;

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
BirthDate DATE,
EnrollmentDate DATE
);


CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
DepartmentID INT,
Salary DECIMAL(10, 2),
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100) NOT NULL,
DepartmentID INT,
Credits INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollmentDate DATE,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
UNIQUE (StudentID, CourseID)
);


INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Biology'),
(5, 'History'),
(6, 'English'),
(7, 'Electrical Engineering');


INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(101, 'Gopi', 'Gadara', 'gopi.gadara@uni.edu', '2000-01-15', '2021-08-01'),
(102, 'Jiya', 'Patel', 'jiya.patel@uni.edu', '1999-05-25', '2023-01-10'),
(103, 'Dipal', 'Shah', 'dipal.shah@uni.edu', '2002-11-03', '2023-09-05'),
(104, 'Mishwa', 'Sharma', 'mishwa.sharma@uni.edu', '2001-03-20', '2022-12-15'),
(105, 'Aarohi', 'Gupta', 'aarohi.gupta@uni.edu', '2003-07-11', '2024-02-20'),
(106, 'Trisha', 'Dalsaniya', 'trisha.dalsaniya@uni.edu', '1998-02-10', '2020-08-01'),
(107, 'Zara', 'Mehta', 'zara.mehta@uni.edu', '2004-12-01', '2024-03-01');


INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID, Salary) VALUES
(201, 'Ramesh', 'Iyer', 'ramesh.iyer@uni.edu', 1, 75000.00),
(202, 'Neha', 'Verma', 'neha.verma@uni.edu', 2, 72000.00),
(203, 'Arjun', 'Patil', 'arjun.patil@uni.edu', 3, 68000.00),
(204, 'Priya', 'Nair', 'priya.nair@uni.edu', 4, 70000.00),
(205, 'Karan', 'Mehta', 'karan.mehta@uni.edu', 5, 65000.00);


INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3), 
(102, 'Data Structures', 1, 4), 
(201, 'Calculus I', 2, 4), 
(202, 'Linear Algebra', 2, 3), 
(301, 'Mechanics', 3, 3), 
(401, 'Biology Fundamentals', 4, 4), 
(501, 'World History', 5, 3); 


INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 101, 101, '2021-08-01'), 
(2, 101, 102, '2021-08-01'), 
(3, 102, 201, '2023-01-10'), 
(4, 103, 101, '2023-09-05'), 
(5, 104, 202, '2022-12-15'), 
(6, 105, 102, '2024-02-20'), 
(7, 106, 501, '2020-08-01'); 


INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(8, 107, 101, '2024-03-01'), 
(9, 104, 301, '2023-01-01'), 
(10, 105, 401, '2024-02-20'), 
(11, 106, 102, '2020-08-01'); 


INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES (108, 'Kelly', 'Green', 'kgreen@uni.edu', '2005-01-01', '2024-04-01');


SELECT * FROM Instructors;

UPDATE Students
SET Email = 'gopi_03@uni.edu'
WHERE StudentID = 101;

DELETE FROM Students
WHERE StudentID = 108;


SELECT *
FROM Students
WHERE EnrollmentDate > '2022-12-31';


SELECT C.CourseName FROM Courses C
JOIN Departments D ON C.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Mathematics' LIMIT 5;


SELECT C.CourseName,
COUNT(E.StudentID) AS EnrolledStudents
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName HAVING COUNT(E.StudentID) > 5;

SELECT S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY S.StudentID, S.FirstName, S.LastName
HAVING COUNT(DISTINCT C.CourseID) = 2; 

SELECT DISTINCT S.FirstName, S.LastName
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Introduction to SQL' OR C.CourseName = 'Data Structures';


SELECT AVG(Credits) AS AverageCredits
FROM Courses;

 SELECT MAX(I.Salary) AS MaxCSInstructorSalary
FROM Instructors I
JOIN Departments D ON I.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Computer Science';

SELECT
    D.DepartmentName,
    COUNT(DISTINCT E.StudentID) AS TotalStudentsEnrolled
FROM Departments D
JOIN Courses C ON D.DepartmentID = C.DepartmentID
JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY D.DepartmentName
ORDER BY TotalStudentsEnrolled DESC;

SELECT
    S.FirstName,
    S.LastName,
    C.CourseName
FROM Students S
INNER JOIN Enrollments E ON S.StudentID = E.StudentID
INNER JOIN Courses C ON E.CourseID = C.CourseID;

SELECT
    S.FirstName,
    S.LastName,
    C.CourseName
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
LEFT JOIN Courses C ON E.CourseID = C.CourseID;

SELECT FirstName, LastName
FROM Students
WHERE StudentID IN (
    -- Subquery 1: Finds StudentIDs in courses that meet the condition
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID IN (
        -- Subquery 2: Finds CourseIDs with more than 10 students
        SELECT CourseID
        FROM Enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);

select studentid, firstname, year(enrollmentdate) as enroll_year from students;

select concat(firstname, ' ', lastname) as instructor_name from instructors;

select e.courseid, c.coursename,count(e.studentid) as total_students,sum(count(e.studentid))
over(order by c.coursename) as running_total
from enrollments e
join courses c on e.courseid = c.courseid
group by e.courseid, c.coursename;

select firstname, lastname,
case
  when year(curdate()) - year(enrollmentdate) > 4 then 'senior'
  else 'junior'
end as status
from students;
