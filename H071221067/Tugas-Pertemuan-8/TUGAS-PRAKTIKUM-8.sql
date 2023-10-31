USE classicmodels;

-- 1.
(SELECT c.customerName, p.productName,
		SUM(od.quantityOrdered) * p.buyPrice 'Modal'
FROM customers c
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
GROUP BY c.customerNumber
ORDER BY `Modal` DESC
LIMIT 3)

UNION

(SELECT c.customerName, p.productName,
		SUM(od.quantityOrdered) * p.buyPrice 'Modal'
FROM customers c
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
GROUP BY c.customerNumber
ORDER BY `Modal`
LIMIT 3);

-- 2.
SELECT `Kota Karyawan/ Customer`, 
		COUNT(`Nama`) 'Jumlah'
FROM (SELECT o.city 'Kota Karyawan/ Customer', CONCAT(e.firstName, ' ', e.lastName) 'Nama'
		FROM offices o
		JOIN employees e
		USING (officecode)
		WHERE CONCAT(e.firstName, ' ', e.lastName) LIKE 'L%'

		UNION

		SELECT city, customername
		FROM customers
		WHERE customername LIKE 'L%'
		) AS a
GROUP BY `Kota Karyawan/ Customer`
ORDER BY `Jumlah` DESC
LIMIT 1;

-- 3.
SELECT CONCAT(firstName, ' ', lastName) 'Nama Karyawan/ Pelanggan',
		'Karyawan' AS 'status'
FROM employees
WHERE officeCode IN (
		SELECT officecode
		FROM employees
		GROUP BY officecode
		HAVING COUNT(employeenumber) = (
			SELECT COUNT(e.employeeNumber) 'Jumlah'
			FROM offices o
			JOIN employees e
			USING (officecode)
			GROUP BY officecode
			ORDER BY `Jumlah`
			LIMIT 1)
		)
		
UNION

SELECT c.customerName, 'Pelanggan' AS 'status'
FROM customers c
JOIN employees e
ON e.employeeNumber = c.salesrepemployeenumber
WHERE e.officeCode IN (
		SELECT officecode
		FROM employees
		GROUP BY officecode
		HAVING COUNT(employeenumber) = (
			SELECT COUNT(e.employeeNumber) 'Jumlah'
			FROM offices o
			JOIN employees e
			USING (officecode)
			GROUP BY officecode
			ORDER BY `Jumlah`
			LIMIT 1)
		)
ORDER BY `Nama Karyawan/ Pelanggan`;

-- 4
SELECT `Tanggal`, 
		GROUP_CONCAT(`Riwayat` ORDER BY `Tanggal` 
		SEPARATOR ' dan ') 'Riwayat'
FROM (
    SELECT o.orderDate 'Tanggal', 'memesan barang' AS 'Riwayat'
    FROM orders o
    WHERE MONTH(o.orderDate) = 4 AND 
	 YEAR(o.orderDate) = 2003
    
    UNION

    SELECT p.paymentDate 'Tanggal', 'membayar pesanan'
    FROM payments p
    WHERE MONTH(p.paymentDate) = 4 AND 
	 YEAR(p.paymentDate) = 2003
) AS a
GROUP BY `Tanggal`
ORDER BY `Tanggal`;

-- 5
SELECT customername 'CustomerName/ EmployeeName',
		country,
		'Customer' AS 'status'
FROM customers
WHERE LEFT(country, 1) IN ('a', 'i', 'u', 'e', 'o') AND 
		RIGHT(country,1) IN ('a', 'i', 'u', 'e', 'o')
		
UNION

SELECT CONCAT(e.firstname, ' ', e.lastname),
		o.country,
		'Employee'
FROM employees e
JOIN offices o
USING (officecode)
WHERE LEFT(country, 1) IN ('a', 'i', 'u', 'e', 'o') AND 
		RIGHT(country,1) IN ('a', 'i', 'u', 'e', 'o')