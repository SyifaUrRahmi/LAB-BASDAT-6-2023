-- TUGAS 7
USE classicmodels;

-- NO 1
SELECT CONCAT_WS(', ', o.addressLine1, o.addressLine2, o.city, o.country) 'Alamat Kantor'
FROM offices AS o
JOIN employees AS e USING (officeCode)
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IN (
    SELECT customerNumber
    FROM payments
    GROUP BY customerNumber
    HAVING COUNT(*)= (SELECT COUNT(amount) 'Jumlah Pembayaran' FROM payments
						 	 GROUP BY customerNumber
							 ORDER BY COUNT(*) 
							 LIMIT 1));
							 

-- NO 2
-- SELECT * FROM customers;

SELECT CONCAT(e.firstname, ' ', e.lastname) 'Nama Employee',
		 FORMAT(SUM(py.amount),2) 'Pendapatan'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS py USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(py.amount) = (
	SELECT MAX(totalAmount) 
	FROM (
		SELECT SUM(py.amount) AS totalAmount 
		FROM customers AS c 
		JOIN payments AS py USING (customerNumber)
		GROUP BY c.salesRepEmployeeNumber) AS MaxPembayaran) 
OR SUM(py.amount) = (
	SELECT MIN(totalAmount) 
	FROM (
		SELECT SUM(py.amount) AS totalAmount
		FROM customers AS c
		JOIN payments AS py USING (customerNumber)
		GROUP BY c.salesRepEmployeeNumber) AS MinPembayaran);

-- NO 3
USE world;

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;

-- cl.percentage/100 itu untuk menghitung perkiraan jumlah populasi yg menggunakan
-- bahasa yg sama
SELECT cy.`Name` 'Negara', (cy.Population * (cl.Percentage/100)) 'Pengguna Bahasa'
FROM country AS cy
JOIN countrylanguage AS cl ON cl.countryCode = cy.`Code`
WHERE cl.`Language` = (SELECT cl.`Language`
							  FROM countrylanguage AS cl
							  JOIN country AS cy ON cy.`Code` = cl.countryCode
						     WHERE cy.Continent = 'Asia'
							  GROUP BY cl.`Language`
							  ORDER BY COUNT(cl.`Language`) DESC
							  LIMIT 1);
							  
							  
-- NO 4
SELECT c.customerName, 
		SUM(py.amount) 'Total pembayaran', 
		SUM(od.quantityOrdered) 'banyak barang', 
		GROUP_CONCAT(p.productName SEPARATOR ', ') 'produk yang dibeli'
FROM customers AS c
JOIN payments AS py USING (customerNumber)
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(py.amount) > (SELECT AVG(total)
								 FROM (SELECT SUM(py1.amount) AS total
										FROM payments AS py1
										GROUP BY customernumber) AS totalpembayaran);


	
										
-- SOAL TAMBAHAN (NO 5)
-- Apakah ada pelanggan yang melakukan pembayaran lebih dari 10 kali? jika ada berapa?

SELECT c.customerName, COUNT(*)
FROM customers AS c
JOIN payments AS p USING (customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(*) > 10;
