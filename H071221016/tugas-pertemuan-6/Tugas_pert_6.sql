USE classicmodels;

#nomor 1
SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS 'Nama Employee',
GROUP_CONCAT(orders.orderNumber) AS 'Nomor Orderan',
COUNT(*) AS 'Jumlah Pesanan'
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN orders
USING (customernumber)
GROUP BY employees.employeeNumber
HAVING COUNT(orders.orderNumber) > 10;

#nomor 2
#min menampilkan data terendah(paling awal)
SELECT products.productCode,products.productName,products.quantityInStock,MIN(orders.orderDate)
FROM orders
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
GROUP BY products.productname
HAVING products.quantityInStock > 5000
ORDER BY orders.orderDate;

#nomor 3
SELECT o.addressline1 AS 'Alamat', 
CONCAT(LEFT(o.phone, LENGTH(o.phone) - 6), '* ****') AS 'Nomor Telp',
COUNT(DISTINCT e.employeeNumber) AS 'jumlah karyawan',
COUNT(DISTINCT  c.customerNumber) AS 'jumlah pelanggan',
AVG(p.amount) AS 'rata-rata penghasilan'
FROM offices o
JOIN employees e 
USING(officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p 
USING(customerNumber)
GROUP BY o.officeCode
ORDER BY o.phone;
#nomor 4
SELECT
	customers.customerName AS 'Customer Name',
   YEAR(orders.orderDate) AS 'Tahun Order',
   MONTHNAME(orders.orderDate) AS 'Bulan Order',
   COUNT(orders.orderNumber) AS 'Jumlah Pesanan',
   SUM(orderdetails.priceEach * orderdetails.quantityOrdered) AS 'Total Penjualan'
FROM
   customers
JOIN
   orders ON customers.customerNumber = orders.customerNumber
JOIN
   orderdetails ON orders.orderNumber = orderdetails.orderNumber
WHERE
   YEAR(orders.orderDate) = 2003
GROUP BY
   customers.customerName, MONTHNAME(orders.orderDate);
   
#soal Tambahan

SELECT UPPER(products.productName),
 COUNT(orderdetails.orderLineNumber) AS 'Jumlah diorder',
SUM(orderdetails.quantityOrdered) AS 'total jumlah orderan',
products.buyPrice AS 'Harga Beli',
orderdetails.priceEach AS 'Harga Jual',
CONCAT(orderdetails.priceEach*(SUM(orderdetails.quantityOrdered)), "-",products.buyPrice * 
(SUM(orderdetails.quantityOrdered))) AS 'keuntungan',
GROUP_CONCAT(orders.orderDate)
FROM orders 
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode)
WHERE products.productName ='2001 ferrari enzo'
GROUP BY orderdetails.priceEach;

   
   






