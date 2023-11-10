USE classicmodels;

-- /No.1/
SELECT * FROM customers;
SELECT c.customerName, p.productName, py.paymentdate, o.status
FROM customers AS C
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS p
		USING (productCode)
JOIN payments AS py
		USING (customerNumber)
WHERE customerName = 'Signal Gift Stores' AND productName LIKE '%Ferrari%';

-- /No.2/
-- A
SELECT c.customerName, py.paymentdate, e.firstName, e.lastName
FROM customers AS c
JOIN payments py
		USING (customerNumber)
JOIN employees AS e
		ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE (MONTH(paymentDate) = 11);

-- B
SELECT c.customerName, py.paymentDate, CONCAT(e.firstName,' ',e.lastName) AS employeeName, py.amount
FROM customers AS c
JOIN payments AS py
		USING (customerNumber)
JOIN employees AS e
		ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE (MONTH(paymentDate) = 11)
ORDER BY py.amount DESC 
LIMIT 1; 

-- C
SELECT * FROM products;
SELECT c.customerName, p.productName
FROM customers AS C
JOIN orders AS o
		USING (customerNumber) 
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS p
		USING (productCode)
WHERE customerName = 'Corporate Gift Ideas Co.';

-- D
SELECT c.customerName, GROUP_CONCAT(p.productName) AS productName
FROM customers AS C
JOIN orders AS o
		USING (customerNumber) 
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS p
		USING (productCode)
WHERE customerName = 'Corporate Gift Ideas Co.';

-- /No.3/
SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF(o.orderDate, o.shippedDate) 'Durasi pengiriman'
FROM customers AS C
JOIN orders AS o
		USING (customerNumber)
WHERE customerName = 'GiftsForHim.com' AND o.shippedDate;

-- /No.4/
USE WORLD;

-- A
SELECT * FROM country;
SELECT Code
FROM country
WHERE Code LIKE 'c_k';

-- B
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy IS NOT NULL;


