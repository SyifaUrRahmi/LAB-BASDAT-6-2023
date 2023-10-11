USE classicmodels

-- Nomor 1
SELECT customers.customerName, products.productName, payments.paymentDate, orders.status
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN payments ON customers.customerNumber = payments.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE products.productname LIKE '%Ferrari%' AND orders.`status` = 'Shipped'

-- Nomor 2 A
SELECT  customers.customerName, CONCAT(employees.firstName,' ',employees.lastName) AS 'Penanggung Jawab', payments.paymentDate
FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE MONTH(payments.paymentDate) = 11

-- Nomor 2 B
SELECT customers.customerName, payments.amount AS 'Total'
FROM customers
JOIN payments ON payments.customerNumber = customers.customerNumber
WHERE MONTH(payments.paymentDate) = 11
ORDER BY payments.amount DESC
LIMIT 1

-- Nomor 2 C
SELECT customers.customerName, products.productName
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
JOIN orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN products ON orderdetails.productCode = products.productCode
WHERE customers.customerName LIKE 'Corporate%'

-- Nomor 3
SELECT customers.customerName, orders.orderDate, orders.shippedDate,(orders.shippedDate - orders.orderDate) AS 'Waktu'
FROM customers
JOIN orders USING(customerNumber)
WHERE customers.customerName = 'GiftsForHim.com' AND orders.shippedDate IS NOT NULL


-- Nomor 4
USE world

-- Nomor 4 A
SELECT `code` FROM country WHERE `code` LIKE 'C%K'

-- Nomor 4 B
SELECT * FROM country WHERE lifeExpectancy IS NOT NULL AND `code` LIKE 'C%K'

-- Soal Tambahan
SELECT customers.customerName, CONCAT(DAYNAME(payments.paymentDate),' ',payments.paymentDate) AS 'Tanggal Bayar', payments.amount
FROM customers
JOIN payments USING(customerNumber)
WHERE DAYNAME(payments.paymentDate) = 'Sunday' AND (customers.customerName LIKE 'a%' OR customers.customerName LIKE 'i%'
OR customers.customerName LIKE 'u%' OR customers.customerName LIKE 'e%' OR customers.customerName LIKE 'o%')