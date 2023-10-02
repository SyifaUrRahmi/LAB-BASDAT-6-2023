USE classicmodels;

## Nomor 1
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', DATE_FORMAT(paymentDate, '%Y-%m-%d') AS tanggal
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
WHERE YEAR(paymentDate) >= 2005
ORDER BY paymentDate;

## Nomor 2
SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM products AS p 
JOIN productlines AS pl
USING (productLine)
JOIN orderdetails
USING (productCode)
JOIN orders 
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
WHERE p.productCode = 'S700_3505';

## Nomor 3
ALTER TABLE products
ADD status VARCHAR(20);

SELECT productCode
FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
JOIN orderdetails AS od 
USING (productCode)
SET STATUS = 'best selling'
WHERE productCode = 's12_4675'
ORDER BY quantityOrdered DESC
LIMIT 1;

SELECT p.productCode, p.productName, od.quantityOrdered, p.status
FROM products AS p
JOIN orderdetails AS od 
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;

## Nomor 4
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;     
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;     
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;     
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;


DELETE customers
FROM customers
JOIN orders AS o
USING (customerNumber)
WHERE o.STATUS = 'Cancelled'

## Nomor 5
ALTER TABLE customers
ADD status VARCHAR(50);

UPDATE customers
SET status = 'Reguler';

UPDATE customers c
JOIN payments AS p
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
SET c.status = 'vip'
WHERE amount > 1000000 OR quantityordered >50;

SELECT c.customerName, p.amount, od.quantityOrdered , c.`status`
from customers c
JOIN payments AS p
USING (customerNumber)
JOIN orders 
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
WHERE c.status = 'vip'
