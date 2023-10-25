USE classicmodels

SELECT c.customername AS 'Nama Ccustomer', c.country AS 'Negara', p.paymentdate AS 'Tanggal'
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate

SELECT distinct c.customername AS 'Nama Customer', p.productname, p.productdescription
FROM customers c
JOIN orders o
ON c.customernumber = o.customernumber
JOIN orderdetails od
ON o.ordernumber = od.ordernumber
JOIN products p
ON od.productcode = p.productcode
WHERE p.productname = 'The Titanic'

SELECT * FROM products
SELECT * FROM orderdetails
ORDER BY quantityordered DESC 

ALTER TABLE products
ADD `status` varchar(20)classicmodels

UPDATE products
SET `status` = 'best selling'
WHERE productcode = 'S12_4675'

SELECT p.productcode, productname, od.quantityOrdered, p.`status`
FROM orderdetails od
JOIN products p
ON od.productcode = p.productcode
ORDER BY quantityordered DESC
LIMIT 1;

SELECT * FROM orders
WHERE `status` = 'cancelled'
SELECT * FROM orderdetails

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (ordernumber) REFERENCES orders (ordernumber) ON UPDATE CASCADE ;

DELETE FROM orders
WHERE `status` = 'cancelled';