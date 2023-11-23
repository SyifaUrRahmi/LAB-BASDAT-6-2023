## Nomor 1
SELECT year(orderdate) 'tahun', COUNT(orderNumber) 'jumlah pesanan',
case
when COUNT(orderNumber) > 150 then 'Banyak'
when COUNT(orderNumber) < 75 then 'sedikit'
ELSE 'Sedang'
END 'kategori pesanan'
FROM orders
GROUP BY `tahun`
ORDER BY `jumlah pesanan`

## Nomor 2
SELECT  CONCAT(firstName, ' ', lastName) AS 'Nama Karyawan', SUM(amount) 'gaji', 
case
when SUM(amount) > (select AVG(total) FROM (SELECT SUM(amount) total 
FROM customers JOIN payments  USING (customerNumber) JOIN employees 
on customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employeeNumber )a) then 'di atas rata-rata total gaji karyawan'
ELSE 'di bawah rata-rata total gaji karyawan'
END 'kategori gaji'
FROM customers 
JOIN payments  
USING (customerNumber)
JOIN employees 
on customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY employeeNumber


## Nomor 3
SELECT customerName 'pelanggan', 
	GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
	COUNT(productCode) 'jumlah produk', 
	SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND SUM(DATEDIFF(shippedDate, orderDate)) > 
(SELECT AVG(total) FROM 
	(SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)a1) THEN 'target 1' 
WHEN MONTH(orderDate) % 2 = 0 AND SUM(DATEDIFF(shippedDate, orderDate)) > 
(SELECT AVG(total) FROM 
	(SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total FROM orders GROUP BY customerNumber)a) THEN 'target 2' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '18'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL
UNION  
SELECT customerName 'pelanggan', 
	GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
	COUNT(productCode) 'jumlah produk', 
	SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND COUNT(productCode) > (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)b1) THEN 'target 3' 
WHEN MONTH(orderDate) % 2 = 0 AND COUNT(productCode) > (SELECT AVG(jumlah)*10 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)b) THEN 'target 4' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '19'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL
UNION  
SELECT customerName 'pelanggan', 
	GROUP_CONCAT(LEFT(productName,4) SEPARATOR ', ') 'tahun pembuatan', 
	COUNT(productCode) 'jumlah produk', 
	SUM(DATEDIFF(shippedDate, orderDate)) 'total durasi pengiriman', 
CASE 
WHEN MONTH(orderDate) % 2 = 1 AND COUNT(productCode) > (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)c1) THEN 'target 5' 
WHEN MONTH(orderDate) % 2 = 0 AND COUNT(productCode) > (SELECT MIN(jumlah)*3 FROM (SELECT COUNT(productname) AS jumlah FROM products GROUP BY productCode)c) THEN 'target 6' 
END 'keterangan' 
FROM orders
JOIN customers USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE LEFT(productName,2) = '20'
GROUP BY customerName
HAVING `keterangan` IS NOT NULL
ORDER BY `keterangan`


## Nomor 5
BEGIN;
SET autocommit = 0;
DELETE FROM employees
WHERE jobTitle = 'Sales Rep'
AND employeeNumber not IN ( SELECT e.employeeNumber
                        FROM customers c
                        JOIN payments p
                        USING (customerNumber)
                        JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
                        WHERE e.jobTitle = 'Sales Rep'
                        GROUP BY e.employeeNumber
								);
SELECT * FROM employees;
ROLLBACK;
SELECT * FROM employees;