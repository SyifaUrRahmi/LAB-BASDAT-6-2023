-- TUGAS 9
USE classicmodels;

-- NO 1
SELECT
    YEAR(orderDate) AS Tahun,
    COUNT(*) AS 'Jumlah Pesanan',
    CASE
        WHEN COUNT(*) > 150 THEN 'Banyak'
        WHEN COUNT(*) < 75 THEN 'Sedikit'
    ELSE 'Sedang'
    END AS 'Kategori Pesanan'
FROM orders
GROUP BY Tahun;

-- NO 2
SELECT 
		CONCAT(e.firstName, ' ', e.lastName) 'Nama Pegawai', 
		SUM(p.amount) 'Gaji', 
		CASE
			WHEN SUM(p.amount) > (SELECT AVG(total) 
										 FROM (SELECT SUM(amount) AS total 
										 		 FROM customers
								 		 		 JOIN payments USING (customerNumber)
								 		       JOIN employees ON employeeNumber = salesRepEmployeeNumber
								 		 		 GROUP BY employeeNumber) AS gajiKaryawan) 
										 THEN 'di atas rata-rata total gaji karyawan'
		ELSE 'di bawah rata-rata total gaji karyawan' 
		END AS 'Kategori Gaji'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p USING (customerNumber)
GROUP BY e.employeeNumber;

-- NO 3
SELECT 
		c.customerName 'Pelanggan', 
		GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ',') 'Tahun_Pembuatan', 
		COUNT(p.productCode) 'Jumlah Produk', 
		SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
		CASE 
			 WHEN MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) 
																				FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
																						FROM orders 
																						GROUP BY customerNumber) AS durasi)
					THEN 'Target 1'
			 WHEN MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(total) 
																				FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS total 
																						FROM orders 
																						GROUP BY customerNumber) AS durasi)
					THEN 'Target 2'
			END AS 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING Keterangan IS NOT NULL 
	
	UNION 	

SELECT c.customerName,
		  GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
		  COUNT(p.productCode),
		  SUM(DATEDIFF(o.shippedDate, o.orderDate)),
		  CASE 
		  		WHEN MONTH(o.orderDate) % 2 = 1 AND 
				 	  COUNT(p.productCode) > (SELECT AVG(total) * 10 
													  FROM (SELECT COUNT(productName) AS total 
													  		  FROM products GROUP BY productCode) AS jumlah10)
				 	  THEN 'Target 3'
		  		WHEN MONTH(o.orderDate) % 2 = 0 AND 
				 	  COUNT(p.productCode) > (SELECT AVG(total) * 10 
													  FROM (SELECT COUNT(productName) AS total 
													  		  FROM products GROUP BY productCode) AS jumlah10)
				  	  THEN 'Target 4'
		  END AS 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'
	GROUP BY c.customerNumber
	HAVING Keterangan IS NOT NULL
	
	UNION
 	
SELECT c.customerName,
		  GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
		  COUNT(p.productCode),
		  SUM(DATEDIFF(o.shippedDate, o.orderDate)),
		  CASE 
			 	WHEN MONTH(o.orderDate) % 2 = 1 AND 
					  COUNT(p.productCode) > (SELECT MIN(total) * 3 
					  								  FROM (SELECT COUNT(productName) AS total 
														 	  FROM products GROUP BY productCode ) AS jumlah3)
					  THEN 'Target 5'
			 	WHEN MONTH(o.orderDate) % 2 = 0 AND 
					  COUNT(p.productCode) > (SELECT MIN(total) * 3 
					  								  FROM (SELECT COUNT(productName) AS total 
														 	  FROM products GROUP BY productCode ) AS jumlah3)
					  THEN 'Target 6'
			END AS 'Keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING Keterangan IS NOT NULL;

