USE classicModels;

## 1
SELECT YEAR(orderDate) AS 'Tahun',COUNT(orderNumber) AS 'Jumlah Pesanan',
			case 
				when COUNT(orderNumber) > 150 then 'Banyak'
				when COUNT(orderNumber) < 75  then 'Sedikit'
				ELSE 'Sedang'
				END
				AS 'Kategori Pesanan'
FROM orders
GROUP BY  YEAR(orderDate);

## 2
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM payments;

SELECT CONCAT(e.firstName,' ',e.lastName) AS 'Nama Pegawai', SUM(p.amount) AS 'Gaji',
				case
					when SUM(p.amount) >= (SELECT AVG(total)
					FROM (SELECT employees.firstname, SUM(payments.amount)AS 'total'					FROM employees
					JOIN customers 
						ON employees.employeeNumber = customers.salesrepemployeeNumber
					JOIN payments 
						USING(customerNumber)
					GROUP BY employeeNumber) AS table_total) then 'gaji diatas rata-rata'
					ELSE 'gaji dibawah rata-rata'
					END 
					AS 'Kategori Gaji'
FROM employees AS e
JOIN customers AS c
		ON e.employeeNumber = c.salesRepEmployeeNumber 
JOIN payments AS p
		USING(customerNumber)
GROUP BY employeeNumber
ORDER BY gaji DESC;

## 3
(SELECT c.customerName AS 'Pelanggan', 
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ',') AS 'Tahun_Pembuatan', 
			 COUNT(p.productCode) AS 'Jumlah Produk', 
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 1'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 2'
			END 
			AS 'keterangan'
	FROM customers AS c
	JOIN orders AS o 
		USING (customerNumber)
	JOIN orderdetails AS od 
		USING (orderNumber)
	JOIN products AS p 
		USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 3'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 4'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o 
	USING (customerNumber)
	JOIN orderdetails AS od 
	USING (orderNumber)
	JOIN products AS p 
	USING (productCode)
	WHERE p.productName LIKE '19%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 5'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 FROM (	SELECT COUNT(productName) AS total FROM products GROUP BY productCode ) a)
					then 'Target 6'
			END  'keterangan'
	FROM customers AS c
	JOIN orders AS o 
			USING (customerNumber)
	JOIN orderdetails AS od 
			USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
	ORDER BY `keterangan`
