USE classicmodels

#NO. 1
SELECT
	c.customerName, 
	p.productName, 
	py.paymentDate,
	o.`status`
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE c.customerName = 'Signal Gift Stores' AND p.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped'



#NO. 2
SELECT
	c.customerName,
	py.paymentDate,
	CONCAT (e.firstName, ' ', e.lastName) AS employee,
	py.amount
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(py.paymentDate) = '11' 

SELECT
	c.customerName,
	py.paymentDate,
	CONCAT (e.firstName, ' ', e.lastName) AS employee,
	py.amount
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(py.paymentDate) = '11' ORDER BY py.amount 
DESC LIMIT 1

SELECT 
	c.customerName,
	p.productName
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING(productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' AND MONTH(py.paymentDate) = '11'

SELECT 
	c.customerName,
	GROUP_CONCAT(p.productName SEPARATOR ', ') AS productName
FROM payments AS py
JOIN customers AS c
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING(productCode)
WHERE c.customerName = 'Corporate Gift Ideas Co.'



#NO. 3
SELECT
	c.customerName,
	o.orderDate,
	o.shippedDate,
	ABS(DATEDIFF(o.orderDate, o.shippedDate)) AS dayDifference
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com'
 


#NO. 4
USE world
SELECT * FROM country
WHERE `Code` LIKE 'c%k' AND lifeExpectancy IS NOT NULL

SELECT
	p.customerNumber,
    c.customerName,
    p.paymentDate,
    p.amount
FROM payments p
JOIN customers c
USING (customerNumber)
WHERE DAYNAME (p.paymentdate) = 'Sunday' AND LEFT(c.customerName, 1) IN ('a', 'e', 'i', 'o', 'u')




SELECT
    p.customerNumber,
    c.customerName,
    p.paymentDate,
    p.amount
FROM payments AS p
JOIN customers AS c
ON p.customerNumber = c.customerNumber
WHERE WEEKDAY(p.paymentDate) = 6
AND LEFT(c.customerName, 1) IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u')