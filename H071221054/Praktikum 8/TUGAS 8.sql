-- TUGAS 8
USE classicmodels;

-- NO 1
(SELECT c.customerName, 
		  p.productName, 
		  p.buyPrice * SUM(od.quantityOrdered) 'Modal'
FROM customers AS C
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
GROUP BY c.customerNumber
ORDER BY `Modal` DESC
LIMIT 3)
UNION
(SELECT c.customerName, 
		  p.productName,
		  p.buyPrice * SUM(od.quantityOrdered) 'Modal'
FROM customers AS C
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
GROUP BY c.customerNumber
ORDER BY `Modal`
LIMIT 3);


-- NO 2
SELECT * FROM offices;
SELECT * FROM customers;

SELECT `Kota`, 
		  COUNT(`Nama`) 'Jumlah Karyawan / Pelanggan'
FROM (SELECT o.city 'Kota', 
		CONCAT(e.firstName, ' ', e.lastName) 'Nama'
		FROM offices AS o
		JOIN employees AS e USING (officeCode)
		WHERE CONCAT(e.firstName, ' ', e.lastName) LIKE 'L%'
		UNION
		SELECT city, customerName
		FROM customers AS c
		WHERE c.customerName LIKE 'L%'
		) AS kota
GROUP BY `Kota`
ORDER BY `Jumlah Karyawan / Pelanggan` DESC
LIMIT 1;

-- NO 3
SELECT CONCAT(firstName, ' ' , lastName) 'Nama Karyawan/Pelanggan',
		 'Karyawan' AS 'status'
FROM employees
WHERE officeCode IN (
		SELECT officeCode
		FROM employees
		GROUP BY officeCode
		HAVING COUNT(employeeNumber) = (SELECT COUNT(e.employeeNumber) 'Jumlah'
			                    			  FROM offices AS o
												  JOIN employees AS e USING (officecode)
												  GROUP BY officeCode
												  ORDER BY `Jumlah`
												  LIMIT 1)
		)	
UNION
SELECT c.customerName, 
		 'Pelanggan' AS 'status'
FROM customers AS C
JOIN employees AS e ON e.employeeNumber = c.salesrepemployeenumber
WHERE e.officeCode IN (
		SELECT officeCode
		FROM employees
		GROUP BY officeCode
		HAVING COUNT(employeenumber) = (SELECT COUNT(e.employeeNumber) 'Jumlah'
												  FROM offices AS o
											     JOIN employees AS e USING (officecode)
												  GROUP BY officecode
												  ORDER BY `Jumlah`
												  LIMIT 1)
		)
ORDER BY `Nama Karyawan/Pelanggan`;

-- NO 4
SELECT `tanggal`, 
		  GROUP_CONCAT(`Riwayat` SEPARATOR ' dan ') 'Riwayat'
FROM (
    SELECT o.orderDate 'tanggal', 
	 		  'memesan barang' AS 'Riwayat'
    FROM orders AS o
    WHERE MONTH(o.orderDate) = 4 AND YEAR(o.orderDate) = 2003
    UNION
    SELECT p.paymentDate 'tanggal', 
	 		  'membayar pesanan'
    FROM payments AS p
    WHERE MONTH(p.paymentDate) = 4 AND YEAR(p.paymentDate) = 2003
) AS riwayat
GROUP BY `tanggal`
ORDER BY `tanggal`;


-- SOAL TAMBAHAN NO 5
SELECT customerName AS 'customerName/employeeName',
		 country,
		 'customer' AS 'status'
FROM customers
WHERE LEFT(country,1) IN ('a', 'i', 'u', 'e', 'o') AND 
RIGHT(country,1) IN ('a', 'i', 'u', 'e', 'o')
UNION
SELECT CONCAT(e.firstName, ' ', e.lastName) 'customerName/employeeName',
		 o.country,
		 'employee'
FROM employees AS e
JOIN offices AS o USING (officeCode)
WHERE LEFT(country,1) IN ('a', 'i', 'u', 'e', 'o') AND 
RIGHT(country,1) IN ('a', 'i', 'u', 'e', 'o')
ORDER BY `customerName/employeeName`;

