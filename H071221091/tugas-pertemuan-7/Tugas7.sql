-- Nomor 1
USE classicmodels;

SELECT o.addressLine1,
       o.addressLine2,
       o.city AS 'kota',
       o.country AS 'negara',
       COUNT(p.amount) AS 'Jumlah pembayaran'
FROM employees AS e
JOIN customers AS c 
		ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices AS o 
		USING (officeCode)
JOIN payments AS p 
		USING (customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(*) = (
        				 SELECT COUNT(*)
				       FROM payments
				       GROUP BY customerNumber
				       ORDER BY COUNT(*)
				       LIMIT 1 );

-- Nomor 2
USE classicmodels;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee',
		 SUM(p.amount) AS 'pendapatan' 
FROM employees AS e 
JOIN customers AS c
		ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
		USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
		 (SELECT SUM(p.amount) 
		 FROM payments AS p
		 JOIN customers AS c
		 		USING (customerNumber)
		 JOIN employees AS e
		 		ON e.employeeNumber = c.salesRepEmployeeNumber
		 GROUP BY e.employeeNumber
		 ORDER BY SUM(p.amount) DESC 
		 LIMIT 1)
OR SUM(p.amount) =
		 (SELECT SUM(p.amount) 
		 FROM payments AS p
		 JOIN customers AS c
		 		USING (customerNumber)
		 JOIN employees AS e
				ON e.employeeNumber = c.salesRepEmployeeNumber
		 GROUP BY e.employeeNumber
		 ORDER BY SUM(p.amount)
		 LIMIT 1);

-- Nomor 3
USE world;

SELECT c.`Name` AS 'Negara',
		 (c.Population * cl.Percentage/100) AS 'Pengguna Bahasa'
FROM country AS c
JOIN countrylanguage AS cl
		ON c.`Code` = cl.CountryCode
WHERE cl.`Language` =
		(SELECT countrylanguage.`Language` 
		FROM countrylanguage
		JOIN country
				ON country.`Code` = countrylanguage.CountryCode
		WHERE country.Continent = 'Asia'
		GROUP BY countrylanguage.`Language`
		ORDER BY COUNT(countrylanguage.`Language`) DESC
		LIMIT 1)
ORDER BY (c.Population * cl.Percentage) DESC;	

-- Nomor 4
USE classicmodels;

SELECT c.customerName,
		 SUM(p.amount) AS 'Total pembayaran',
		 SUM(od.quantityOrdered) AS 'banyak barang',
		 GROUP_CONCAT(pr.productName SEPARATOR '; ') AS 'produk yang dibeli'
FROM payments AS p
JOIN customers AS C
		USING (customerNumber)
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS pr
		USING (productCode)
GROUP BY customerNumber
HAVING SUM(p.amount) >
		 (SELECT AVG(jumlah)
		 FROM (
		 		SELECT SUM(amount) AS 'jumlah'
		 		FROM payments 
		 		GROUP BY customerNumber) AS a)
ORDER BY SUM(p.amount) DESC;

-- nomor 5 tambahan
SELECT DISTINCT c.customerName, p.productName
FROM customers AS c
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS p
		USING (productCode)
HAVING c.customerName = (SELECT customerName
								FROM customers
								ORDER BY creditLimit DESC
								LIMIT 1);

			
			

			

			
			
			
			