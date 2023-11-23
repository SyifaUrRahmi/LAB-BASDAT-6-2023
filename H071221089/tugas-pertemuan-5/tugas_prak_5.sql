## Nomor 1
SELECT 
   c.customerName, 
   p.productName, 
   py.paymentDate, 
   o.status
FROM customers AS C
JOIN payments AS py
USING (customerNumber)
JOIN orders AS  o 
USING (customerNumber)
JOIN orderdetails AS  od
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE p.productName LIKE  '%Ferrari%' 
AND o.status = 'Shipped' ;

## Nomor 2
# A
SELECT c.CustomerName 'nama customer', p.paymentDate 'tanggal pembayaran', CONCAT (e.firstName, ' ' ,e.lastName) AS fullName
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11;
# B
SELECT c.CustomerName 'nama customer', p.paymentDate 'tanggal pembayaran', CONCAT (e.firstName, ' ' ,e.lastName) AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate) = 11
ORDER BY amount DESC
LIMIT 1;
# C
SELECT 
   c.customerName, 
   p.productName
FROM customers AS C
JOIN payments AS py
USING (customerNumber)
JOIN orders AS  o 
USING (customerNumber)
JOIN orderdetails AS  od
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE MONTH(py.paymentDate) = 11
and customerName LIKE '%corporate%'

# D
SELECT 
   c.customerName, 
   GROUP_CONCAT(p.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers AS c
JOIN payments AS py
USING (customerNumber)
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p 
ON od.productCode = p.productCode
WHERE c.customerName LIKE '%corporate%';

## Nomor 3
SELECT customerName, orderDate, shippedDate, DATEDIFF(shippedDate, orderDate) AS 'menunggu selama', status
FROM orders  
JOIN customers 
USING (customerNumber)
WHERE customerName LIKE '%GiftsForHim.com%';

## Nomor 4
SELECT * FROM country
WHERE code LIKE 'C%K' AND lifeExpectancy IS NOT NULL;

## Nomor 5
SELECT 
	c.customerName,
	DAYNAME(p.paymentDate) AS 'tanggal pembayaran'
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
WHERE LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
AND DAYNAME(p.paymentDate) = 'sunday'
	