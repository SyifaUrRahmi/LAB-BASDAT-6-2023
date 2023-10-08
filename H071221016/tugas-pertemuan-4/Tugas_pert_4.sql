USE classicmodels;
--- nomor 1----
SELECT customers.customerName AS 'Nama Customer',customers.country AS Negara,payments.paymentDate AS tanggal
FROM customers 
INNER JOIN payments 
ON  customers.customerNumber = payments.customerNumber 
WHERE payments.paymentDate >= '2005-01-01' ORDER BY payments.paymentDate;

--- nomor 2 ---
SELECT DISTINCT  customers.customerName AS 'Nama customer', products.productName,productlines.textDescription
FROM customers
JOIN  orders
USING (customerNumber) 
JOIN orderdetails USING (ordernumber) 
JOIN products USING (productCode) 
JOIN productlines USING (productline) 
WHERE productName = 'The Titanic';

--- nomor 3 ---
ALTER TABLE products ADD COLUMN STATUS VARCHAR(20);
SELECT * FROM orderdetails;
SELECT quantityordered,productcode FROM orderdetails ORDER BY quantityordered DESC;
UPDATE products SET STATUS = 'best stelling' WHERE productcode = 'S12_4675';

SELECT products.productcode ,products.productName,orderdetails.quantityOrdered,products.`STATUS`
FROM products 
JOIN orderdetails
ON products.productCode = orderdetails.productCode ORDER BY quantityordered DESC LIMIT 1;

--- nomor 4 ----
SELECT * FROM orders;
SELECT * FROM orderdetails;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customernumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customernumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

DELETE customers FROM customers 
INNER JOIN orders 
USING (customernumber)
WHERE orders.`status` ='cancelled';

---- soal Tambahan ---

ALTER TABLE customers ADD STATUS VARCHAR(20);

UPDATE customers SET STATUS = 'Regular';
SELECT STATUS FROM customers;

UPDATE customers
INNER JOIN 
payments  
USING (customernumber)
INNER JOIN orders
USING (customernumber)
INNER JOIN orderdetails
USING (ordernumber)
SET customers.STATUS = 'vip' WHERE payments.amount > 100000 
OR  orderdetails.quantityordered > 50;
SELECT * FROM customers;

SELECT DISTINCT customers.customerName,customers.`status`,orderdetails.quantityOrdered,payments.amount
FROM customers
INNER JOIN orders
USING (customernumber)
INNER JOIN orderdetails
USING (ordernumber)
INNER JOIN payments  
USING (customernumber)
WHERE payments.amount > 100000 
OR  orderdetails.quantityordered > 50 ;




