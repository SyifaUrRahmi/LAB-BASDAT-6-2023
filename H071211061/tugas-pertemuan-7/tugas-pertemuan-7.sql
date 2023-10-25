NO 1
SELECT CONCAT('jalan ', offices.addressline1, ' kota ', offices.city, ' ',offices.country) AS alamat FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices
USING(officeCode)
WHERE customerNumber IN (
	SELECT customerNumber FROM payments
	GROUP BY customerNumber
	HAVING COUNT(*) = (SELECT COUNT(*) FROM payments
							GROUP BY customerNumber
							ORDER BY COUNT(*) LIMIT 1)
);

NO 2
SELECT CONCAT (e.lastName,' ',e.firstName) AS 'employee', SUM(py.amount)
AS 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
ON py.customerNumber = c.customerNumber
WHERE e.employeeNumber IN ((SELECT e.employeeNumber
								FROM employees e
								JOIN customers c
								ON e.employeeNumber = c.salesRepEmployeeNumber
								JOIN payments py
								ON py.customerNumber = c.customerNumber
								GROUP BY e.employeeNumber
								ORDER BY SUM(py.amount) desc
								LIMIT 1),
								(SELECT e.employeeNumber
								FROM employees e
								JOIN customers c
								ON e.employeeNumber = c.salesRepEmployeeNumber
								JOIN payments py
								ON py.customerNumber = c.customerNumber
								GROUP BY e.employeeNumber
								ORDER BY SUM(py.amount) asc
								LIMIT 1))

GROUP BY e.employeeNumber

NO 3
USE world;
SELECT c.Name AS `Negara`, (cl.Percentage/100 * c.Population) AS
`Masyarakat`
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.`Language` =
	(SELECT cl.`Language`
	FROM countrylanguage cl
	JOIN country c
	ON c.Code = cl.CountryCode
	WHERE c.Continent = 'Asia'
	GROUP BY cl.`Language`
	ORDER BY count(LANGUAGE) DESC
	LIMIT 1)
ORDER BY `Masyarakat` DESC;

NO 4
USE classicmodels;
SELECT c.customerName, round(SUM(pa.amount),2) AS `Total pembayaran`,
sum(od.quantityOrdered) AS `banyak barang`, group_concat(p.productName)
AS `produk yang dibeli`
FROM customers c
JOIN payments pa
USING(customerNumber)
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
HAVING SUM(pa.amount) > (SELECT ROUND(AVG(jumlah),2) AS 'avg '
								FROM (SELECT SUM(amount) AS jumlah
										FROM payments
										GROUP BY customernumber) jum)
ORDER BY sum(pa.amount) DESC;