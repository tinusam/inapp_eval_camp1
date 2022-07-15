--Question 1

Create database final_project

--Create a department table 
CREATE TABLE department(
	dept_no INT  PRIMARY KEY,
	dept_name VARCHAR(50)
	);


CREATE TABLE employeedetails(
	emp_id  INT  PRIMARY KEY ,
	emp_name VARCHAR(50),
	pay INT
	);

CREATE TABLE deptId(
	emp_id INT PRIMARY KEY ,
	dept_no INT 
	);

--INSERT VALUE TO Department
INSERT INTO department
VALUES (101, 'IT'),
(102, 'Sales'),
(103,'Marketing'),
(104, 'HR')

--INSERING VALUE TO Employeedetails
INSERT INTO employeedetails VALUES
(001, 'Dilip', 3000),
(002,'Fahad',4000),
(003,'Lal',6000),
(004,'Nivin',2000),
(005,'Vijay',9000),
(006,'Anu',5000),
(007,'Nimisha',5000),
(008,'Praveena',8000)

--INSERTING VALUE TO dept_id
INSERT INTO deptId VALUES
	(001,101),
	(002,102),
	(003,103),
	(004,101),
	(005,102),
	(006,104),
	(007,102),
	(008,103)

SELECT * FROM department
select * from employeedetails
SELECT * FROM deptId

--1) The total number of employees
SELECT COUNT(emp_id) AS 'TOTAL EMPLOYEE' FROM employeedetails;

--2) Total amount required to pay all employees
SELECT SUM(pay) AS 'TOTAL AMOUNT' FROM employeedetails;

--3) Average, minimum and maximum pay in the organization
SELECT AVG(pay) AS 'Average Pay' FROM employeedetails;
SELECT MAX(pay) AS 'Maximum Pay' FROM employeedetails;
SELECT MIN(pay) AS 'Minimum Pay' FROM employeedetails;

--4) Each Department wise total pay
SELECT department.dept_name,SUM(employeedetails.pay)
FROM employeedetails
INNER JOIN deptId ON employeedetails.emp_id = deptId.emp_id
INNER JOIN department ON deptId.dept_no = department.dept_no
GROUP BY dept_name

--5) Average, minimum and maximum pay department-wise.
SELECT department.dept_name,AVG(employeedetails.pay) AS average,MAX(employeedetails.pay) AS Max,MIN(employeedetails.pay) AS Min
FROM employeedetails
INNER JOIN deptId ON employeedetails.emp_id = deptId.emp_id
INNER JOIN department ON deptId.dept_no = department.dept_no
GROUP BY dept_name


--6) Employee details who earns the maximum pay.SELECT * FROM employeedetails 
WHERE pay = (SELECT MAX(pay) FROM employeedetails);--7)   Employee details who is having a maximum pay in the department.--9) Employee who has more pay than the average pay of his department
SELECT emp_name FROM employeedetails 
WHERE pay > (SELECT AVG(pay) FROM employeedetails)
go

--10) Unique departments in the company
SELECT DISTINCT dept_name FROM Department;

--11) Employees In increasing order of pay
SELECT * FROM employeedetails
ORDER BY pay;
--12)Department In increasing order of paySELECT department.dept_name,SUM(employeedetails.pay) AS pay
FROM employeedetails
INNER JOIN deptId ON employeedetails.emp_id = deptId.emp_id
INNER JOIN department ON deptId.dept_no = department.dept_no
GROUP BY dept_name
ORDER BY pay




