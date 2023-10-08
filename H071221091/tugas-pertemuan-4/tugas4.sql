USE classicmodels;

-- No.1
SHOW TABLES

DESC customers;
DESC payments;

SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c
JOIN payments AS p
		ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

-- No.2
SHOW TABLES

DESC customers;
DESC orders;
DESC orderdetails;
DESC products;

SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
		ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
		ON o.orderNumber = od.orderNumber
JOIN products p
		ON od.productCode = p.productCode
JOIN productlines AS pl
		ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

-- No.3
DESC products;

-- buat field
ALTER TABLE products
ADD `status` VARCHAR(20);
SELECT*FROM products;

-- cek pesanan
SELECT * FROM orderdetails
ORDER BY quantityordered DESC
LIMIT 1

-- update datanya
UPDATE products
SET `status` = 'best selling'
WHERE productcode = 'S12_4675';
-- cek lagi
SELECT productCode,`status` FROM products
WHERE productCode = 'S12_4675';

-- tampilkan datanya
SELECT p.productCode, p.productName, od.quantityordered, p.`status`
FROM products AS p
JOIN orderdetails AS od
		ON od.productCode = p.productCode
ORDER BY quantityordered DESC 
LIMIT 1;

-- No.4
SELECT * FROM orders
WHERE `status` = 'cancelled';
-- SELECT * FROM orderdetails;

DELETE c FROM customers AS c 
JOIN orders AS o
		ON o.customerNumber = c.customerNumber
WHERE `status` = 'cancelled';
SELECT * FROM orders
WHERE `status` = 'cancelled';

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;


-- NO.5
ALTER TABLE customers
ADD `status` VARCHAR(255);
SELECT*FROM customers;

UPDATE customers 
SET `status` = 'Regular';

-- update
UPDATE customers AS c
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN payments AS p
		USING (customerNumber)
SET c.`status` = 'VIP'
WHERE p.amount > 100000 OR od.quantityOrdered >= 50;

-- cek update
SELECT c.customerName , od.quantityOrdered ,c.status, p.amount
FROM customers AS c
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN payments AS p
		USING (customerNumber)
WHERE p.amount > 100000 OR od.quantityOrdered >= 50;

-- cek keseluruhan
SELECT c.customerName , od.quantityOrdered ,c.status, p.amount
FROM customers AS c
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN payments AS p
		USING (customerNumber)

-- - Buatlah kolom baru dengan nama status yang bertipe data varchar pada tabel 
-- customers
-- - Kemudian isi dengan nilai ‘VIP’ untuk pelanggan yang jumlah pembayarannya pernah 
-- diatas 100.000 atau yang pernah mengorder barang dengan kuantitas 50 keatas
-- - Sisanya isi dengan nilai ‘Regular’.







