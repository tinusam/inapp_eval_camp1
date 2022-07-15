USE final_project

CREATE TABLE customerdetails(
	custId INT IDENTITY PRIMARY KEY,
	customername VARCHAR(50)
);

CREATE TABLE orderdetails(
	OrderId INT IDENTITY PRIMARY KEY,
	OrderDate DATE,
	OrderPrice INT,
	OrderQuantity INT,
	custId INT FOREIGN KEY REFERENCES customerdetails(custId)
	);

CREATE TABLE Product(
	 productno INT IDENTITY PRIMARY KEY,
    productname VARCHAR(15)
)

CREATE TABLE ManufactureDetails(
    manuft_id INT IDENTITY PRIMARY KEY,
    manuft_name VARCHAR(15)
)

CREATE TABLE ProductDetails(
    productid INT,
    orderid INT FOREIGN KEY REFERENCES OrderDetails(orderid),
    manuft_date DATE,
    productno INT FOREIGN KEY REFERENCES Product(productno),
    manuft_id INT FOREIGN KEY REFERENCES ManufactureDetails(manuft_id)
)

INSERT INTO customerdetails VALUES
('Jayesh'), 
('Abhilash'),
('Lily'),
('Aswathy')

INSERT INTO orderdetails VALUES
('2020-12-22',270,2,1),
('2019-08-10',280,4,2),
('2019-07-13',600,5,3),
('2020-07-15',520,1,1),
('2020-12-22',1200,4,4),
('2019-10-02',720,3,1),
('2020-11-03',3000,2,3),
('2020-12-22',1100,4,4),
('2019-12-29',5500,2,1)

INSERT INTO Product VALUES
('Mobile Phone'),
('LED TV'),
('Laptop'),
('Headphone'),
('Power bank')

INSERT INTO ManufactureDetails VALUES
('Samsung'),
('Sony'),
('Mi'),
('Boat')

INSERT INTO ProductDetails VALUES
(145,2,'2019-12-23',1,1),
(147,6,'2019-08-15',1,3),
(435,5,'2018-11-04',1,1),
(783,1,'2017-11-03',2,2),
(784,4,'2019-11-28',2,2),
(123,2,'2019-10-03',3,2),
(267,5,'2019-03-21',4,4),
(333,9,'2017-12-12',3,1),
(344,3,'2018-11-03',3,1),
(233,3,'2019-11-30',5,2),
(567,6,'2019-09-03',5,2)

SELECT * FROM CustomerDetails
SELECT * FROM OrderDetails
SELECT * FROM Product
SELECT * FROM ManufactureDetails
SELECT * FROM ProductDetails

--1. Total number of orders placed in each year.
SELECT SUM(OrderQuantity) AS 'Total orders each year',
DATENAME(year, orderdate) AS 'Year' 
FROM OrderDetails
GROUP BY DATENAME(year, orderdate)

--2. Total number of orders placed in each year by Jayesh.
SELECT COUNT(orderid) AS 'Total orders by Jayesh'
FROM OrderDetails
WHERE custId = 1

--3. Products which are ordered in the same year of its manufacturing year.
SELECT p1.productname, o1.orderdate, p2.manuft_date
FROM Product p1, orderdetails o1, ProductDetails p2
WHERE DATENAME(year,o1.orderdate)=DATENAME(year,p2.manuft_date)

--4. Products which is ordered in the same year of its manufacturing year where the Manufacturer is ‘Samsung’.
SELECT p1.productname, o1.orderdate, p2.manuft_date
FROM Product p1, orderdetails o1, ProductDetails p2
WHERE DATENAME(year,o1.orderdate)=DATENAME(year,p2.manuft_date) 
AND p2.manuft_id = 1

--5. Total number of products ordered every year.
SELECT COUNT(productid) AS 'Total no of products each year',
DATENAME(year, manuft_date) AS 'Year' 
FROM ProductDetails
GROUP BY DATENAME(year, manuft_date)

--6. Display the total number of products ordered every year made by sony.
SELECT COUNT(productid) AS 'Total no of products each year',
DATENAME(year, manuft_date) AS 'Year' 
FROM ProductDetails
WHERE manuft_id = 2
GROUP BY DATENAME(year, manuft_date)

--7. All customers who are ordering mobile phone by samsung.
SELECT DISTINCT c1.customername FROM customerdetails c1, ProductDetails p2
WHERE p2.productno=1 AND p2.manuft_id=1 

--8. Total number of orders got by each Manufacturer every year.
SELECT COUNT(*) AS 'Total orders' FROM ProductDetails
GROUP BY manuft_id

--9. All Manufacturers whose products were sold more than 1500 Rs every year.
SELECT m1.manuft_name FROM ManufactureDetails m1, ProductDetails p2 
WHERE (SELECT SUM(o1.orderprice) FROM OrderDetails o1
WHERE o1.orderid=p2.orderid)>1500 
AND p2.manuft_id = m1.manuft_id