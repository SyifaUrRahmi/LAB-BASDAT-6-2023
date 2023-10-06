-- TUGAS PRAKTIKUM 4

USE classicmodels;

-- NO 1
SELECT * FROM customers;
SELECT * FROM payments;

SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
WHERE p.paymentDate >= '2005-01-01'
ORDER BY paymentDate;

-- NO 2
-- SELECT * FROM customers;
-- SELECT * FROM productlines;
-- SELECT * FROM products;
-- SELECT * from orders;
-- SELECT * from orderdetails;

SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
JOIN productlines AS pl USING (productLine)
WHERE p.productName = 'The Titanic';

-- NO 3
ALTER TABLE products
ADD COLUMN `status` VARCHAR(20);

SELECT * FROM orderdetails;
-- mencari produk yang mempunyai pesanan yang terbanyak dalam 1x pesanan
SELECT quantityOrdered, productCode
FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

-- update status produk yg mempunyai pesanan terbanyak
UPDATE products
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;


-- NO 4
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD FOREIGN KEY (customernumber) REFERENCES customers (customernumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE payments 
ADD FOREIGN KEY (customernumber) REFERENCES customers (customernumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE orderdetails
ADD FOREIGN KEY (ordernumber) REFERENCES orders (ordernumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

DELETE c
FROM customers c
JOIN orders o 
USING (customernumber)
WHERE o.`status` = 'Cancelled';

SELECT customerNumber, orderNumber, `status`
FROM orders
WHERE `status` = 'Cancelled';

-- soal tambahan no 5
ALTER TABLE customers
ADD COLUMN `status` VARCHAR(20);

UPDATE customers
SET `status` = 'Regular';

UPDATE customers
JOIN payments
USING(customerNumber)
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
SET customers.`status` = 'VIP'
WHERE payments.amount > 100000 OR orderdetails.quantityOrdered >= 50;

SELECT * FROM payments;
SELECT * FROM customers;

SELECT customers.customerName, payments.amount, orderdetails.quantityOrdered, customers.`status`
FROM customers
JOIN payments
USING(customerNumber)
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber);










