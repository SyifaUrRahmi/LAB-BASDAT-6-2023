-- TUGAS 5
USE classicmodels;
-- NO 1
-- SELECT * FROM customers;
-- SELECT * FROM payments;
-- SELECT * FROM orders;
-- SELECT * FROM orderdetails;
-- SELECT * FROM products;

SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS py USING (customerNumber)
JOIN orders AS o USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE c.customerName LIKE '%Signal Gift%' AND p.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped';

-- NO 2
# a
SELECT c.customerName, p.paymentDate, e.firstName, e.lastName
FROM customers AS c
JOIN payments AS p USING (customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11;

# b
SELECT c.customerName, p.paymentDate, p.amount, CONCAT(e.firstName,' ',e.lastName) AS 'Full Name'
FROM customers AS c
JOIN payments AS p USING (customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11
ORDER BY amount DESC
LIMIT 1;

# c (41 x 2)
SELECT c.customerName, p.productName
FROM customers AS c
JOIN payments AS py USING (customerNumber)
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE c.customerName LIKE '%corporate%' AND MONTH(py.paymentDate) = 11;

# d 
SELECT c.customerName, GROUP_CONCAT(' ',p.productName) 'productName'
FROM customers AS c
JOIN payments AS py USING (customerNumber)
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products AS p USING (productCode)
WHERE c.customerName LIKE '%corporate%' AND MONTH(py.paymentDate) = 11;

-- NO 3
SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF(o.shippedDate, o.orderDate) 'Menunggu Selama (Hari)'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
WHERE c.customerName = 'giftsforhim.com';

-- NO 4
USE world;

SELECT * FROM country
WHERE `Code` LIKE 'C%K' AND LifeExpectancy IS NOT NULL;

-- soal tambahan
SELECT c.customerName, DAYNAME(p.paymentDate) 'pembayaran'
FROM customers AS c
JOIN payments AS p USING (customerNumber)
WHERE DAYNAME(p.paymentDate) = 'sunday' AND LEFT(c.customerName,1) IN ('A','I','U','E','O');

