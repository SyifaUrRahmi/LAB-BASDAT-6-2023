USE classicmodels;

#1
SELECT c.customerName AS "nama customer", c.country AS "negara customer", p.paymentDate AS "tanggal"
FROM customers c 
JOIN payments p  
ON c.customerNumber = p.customerNumber 
WHERE p.paymentDate>"2004-12-31"1
ORDER BY p.paymentDate;

#2
SELECT DISTINCT c.customername AS "Nama Customer", p.productname, pl.textdescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.ordernumber = od.ordernumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = "The Titanic";

#3
ALTER TABLE products
ADD `status` VARCHAR(20);
SELECT * FROM orderdetails;
UPDATE products
SET `status` = "Best Selling"
WHERE productcode = "S12_4675";

SELECT p.productCode, p.productName, od.quantityordered, p.status
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY od.quantityOrdered DESC
LIMIT 1;

#4
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE c
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.status = "Cancelled";

SELECT * FROM orders
WHERE status = "Cancelled";

#5
ALTER TABLE customers
ADD status VARCHAR(20);

UPDATE customers
SET status = "Regular";

SELECT * FROM customers;

UPDATE customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
SET c.status = "VIP"
WHERE p.amount > 100000 OR od.quantityOrdered > 50;

SELECT c.customername, od.quantityordered, p.amount, c.status      
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE p.amount > 100000 OR od.quantityOrdered > 50
ORDER BY p.amount DESC;