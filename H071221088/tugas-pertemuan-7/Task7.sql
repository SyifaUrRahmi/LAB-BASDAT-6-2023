USE classicmodels

-- nomor 1
SELECT DISTINCT o.addressline1, o.addressline2, o.city, o.country
FROM offices AS o
JOIN employees AS e ON o.officeCode = e.officeCode
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(amount) = (SELECT COUNT(amount) 
								FROM payments 
								GROUP BY customerNumber 
								ORDER BY COUNT(amount) ASC LIMIT 1);
						
-- nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', sum(p.amount) AS 'pendapatan'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p USING(customerNumber)
WHERE e.employeeNumber IN ((SELECT e.employeeNumber
									 FROM employees AS e
									 JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
									 JOIN payments AS p USING(customerNumber)
									 GROUP BY employeeNumber
									 ORDER BY SUM(p.amount) ASC
									 LIMIT 1),
									(SELECT e.employeeNumber
									 FROM employees AS e
									 JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
									 JOIN payments AS p USING(customerNumber)
									 GROUP BY employeeNumber
									 ORDER BY SUM(p.amount) DESC
									 LIMIT 1))
GROUP BY CONCAT(e.firstName, ' ', e.lastName);

-- nomor 3
USE world;

SELECT c.Name 'Negara', c.Population*cl.percentage/100 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.language = (SELECT countrylanguage.language
							FROM countrylanguage
							JOIN country ON country.Code = countrylanguage.CountryCode
							WHERE country.Continent = 'Asia'
							GROUP BY countrylanguage.language
							ORDER BY COUNT(countrylanguage.language) DESC
							LIMIT 1)
ORDER BY c.Population*cl.percentage/100 DESC 

-- nomor 4
USE classicModels;

SELECT c.customerName, 
		 SUM(py.amount) AS 'Total pembayaran',
		 SUM(od.quantityOrdered) 'banyak barang',
       GROUP_CONCAT(p.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments py
JOIN customers c USING (customerNumber)
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
GROUP BY customerNumber
HAVING SUM(py.amount) > (SELECT AVG(payments.amount) 
								 FROM payments)
ORDER BY SUM(py.amount) DESC  