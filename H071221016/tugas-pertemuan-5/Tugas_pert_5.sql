USE classicmodels;
#nomor 1
SELECT customers.customerName,products.productName,payments.paymentDate,orders.`status`
FROM customers
INNER JOIN orders
USING (customernumber)
INNER JOIN orderdetails
USING (ordernumber)
INNER JOIN products
USING (productcode)
INNER JOIN payments  
USING (customernumber)
WHERE productname LIKE '%Ferrari%' AND STATUS ='shipped';

#nomor 2
#a
SELECT customers.customerName,payments.paymentDate,employees.firstName,employees.lastName, 
CONCAT (employees.firstName,' ',employees.lastName) AS 'Full Name'
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH (paymentdate)=11;
#b
SELECT customers.customerName,
payments.paymentDate,
payments.amount,
CONCAT (employees.firstName,' ',employees.lastName) AS 'nama karyawan'
FROM customers
JOIN payments
USING (customernumber)
JOIN employees
ON employees.employeeNumber = customers.salesrepemployeenumber
WHERE MONTH(paymentdate)=11
ORDER BY amount DESC LIMIT 1;
#c
SELECT customers.customerName AS 'nama Customers',products.productName AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';
#d
SELECT customers.customerName AS 'nama Customers', GROUP_CONCAT(' ',products.productName) AS 'nama produk'
FROM customers
JOIN orders 
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE customerName ='Corporate Gift Ideas Co.';

#nomor 3
SELECT customers.customerName AS 'Nama Customers',
orders.orderDate AS 'tanggal order',
orders.shippedDate AS 'tanggal pengiriman',
ABS(orders.orderDate-orders.shippedDate) AS lama_menunggu
FROM customers
JOIN orders
USING (customernumber)
WHERE customername ='GiftsForHim.com';

SELECT customers.customerName AS 'Nama Customers',
orders.orderDate AS 'tanggal order',
orders.shippedDate AS 'tanggal pengiriman',
DATEDIFF(orders.shippedDate,orders.orderDate) AS lama_menunggu
FROM customers
JOIN orders
USING (customernumber)
WHERE customername ='GiftsForHim.com';

#nomor 4
USE world;
#a
SELECT * FROM country;
SELECT * FROM country 
WHERE code2 LIKE 'C%K' AND CODE LIKE 'C%K'; 
#b
SELECT * FROM country
WHERE lifeexpectancy != 'null';

SELECT * FROM country 
WHERE CODE LIKE 'C%K' AND lifeexpectancy IS NOT NULL;


#Soal Tambahan

SELECT customers.customername,DAYNAME(payments.paymentDate)
FROM customers 
INNER JOIN payments  
USING (customernumber)
WHERE DAYNAME(paymentdate)='sunday' AND 
(LEFT(customers.customerName,1) IN ('A','I','U','E','O') );


