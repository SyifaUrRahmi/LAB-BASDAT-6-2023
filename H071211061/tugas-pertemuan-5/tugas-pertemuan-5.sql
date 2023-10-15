USE classicmodels;

#1
SELECT customers.customerName, payments.paymentDate, orders.`status`, products.productName
FROM customers
JOIN payments
USING (customernumber)
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE productname LIKE "%ferrari%" and orders.`status`= "shipped"

#2a
SELECT customers.customerName, payments.paymentDate, employees.firstName, employees.lastName
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE MONTH(payments.paymentDate) = 11 

#2b
SELECT customers.customerName, payments.paymentDate, CONCAT(employees.firstName, " ", employees.lastName), payments.amount
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE MONTH(payments.paymentDate) = 11 order BY payments.amount DESC LIMIT 1 

#2c
#Corporate Gift Ideas Co.
SELECT customers.customerName,  products.productName
FROM customers
JOIN payments
USING (customernumber)
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE MONTH(payments.paymentDate) = 11 AND customers.customerName="Corporate Gift Ideas Co."

#3
SELECT customers.customerNumber, orders.shippedDate, orders.orderDate, DATEDIFF(orders.shippedDate, orders.orderDate)
from customers
JOIN orders
USING (customernumber)
WHERE customers.customerName = 'GiftsForHim.com'

#4
SELECT `Code`, LifeExpectancy, `Name` FROM country
WHERE `Code` LIKE 'C%K' AND LifeExpectancy IS NOT NULL

#5
SELECT c.customerName, DAYNAME(p.paymentDate)
FROM customers c
JOIN payments p 
ON c.customerNumber = p.customerNumber
WHERE DAYNAME(p.paymentDate) = 'sunday'
AND (LEFT(c.customerName,1) IN ('a', 'i', 'u', 'e', 'o'))