USE classicmodels


-- Nomor 1
SELECT customers.customername AS 'Nama Customer', customers.country AS 'Negara', payments.paymentDate AS 'tanggal pembayaran'
FROM customers
JOIN payments ON customers.customerNumber = payments.customernumber
WHERE payments.paymentDate > '2004-12-31'
ORDER BY payments.paymentDate 


-- Nomor 2
SELECT DISTINCT customers.customerName AS 'Nama Customer', products.productName, productlines.textDescription
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
JOIN productlines ON productlines.productLine = products.productline
WHERE products.productName = 'The Titanic'

-- Nomor 3
ALTER TABLE products
ADD status VARCHAR(20)

SELECT products.productCode, products.productName, orderdetails.quantityOrdered, products.status
FROM products
JOIN orderdetails ON products.productcode = orderdetails.productCode
ORDER BY quantityordered DESC
LIMIT 1


UPDATE products
SET status = 'best selling'
WHERE productCode = 'S12_4675';

-- Nomor 4
SELECT * FROM orders
WHERE status = 'cancelled';

SELECT customers.customerName, orders.customerNumber, orders.status
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orders.status = 'cancelled';

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE

ALTER TABLE payments DROP FOREIGN KEY _ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE

DELETE customers FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orders.status = 'cancelled'

-- Nomor 5
ALTER TABLE customers
ADD status VARCHAR(20)

SELECT customers.customerName, payments.amount, orderdetails.quantityOrdered, customers.status
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
WHERE customers.status = 'VIP'
ORDER BY payments.amount DESC

UPDATE customers
SET status = 'REGULER'

UPDATE customers
JOIN payments ON customers.customerNumber = payments.customerNumber
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
SET customers.status = 'VIP'
WHERE orderdetails.quantityOrdered > 50 OR payments.amount > 100000