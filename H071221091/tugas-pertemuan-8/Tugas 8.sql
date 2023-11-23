USE classicmodels;

## NO 1
(SELECT c.customerName, p.productName, 
		  (p.buyprice * sum(od.quantityordered)) AS 'modal'
FROM customers AS c
JOIN orders AS o 
		USING(customernumber)
JOIN orderdetails AS od 
		USING(ordernumber)
JOIN products AS p 
		USING(productcode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, 
		  (p.buyprice * SUM(od.quantityordered)) 'modal'
FROM customers AS c
JOIN orders AS o 
		USING(customernumber)
JOIN orderdetails AS od 
		USING(ordernumber)
JOIN products AS p 
		USING(productcode)
GROUP BY c.customerName
ORDER BY modal
LIMIT 3);

## NO 2
SELECT city, 
COUNT(*) AS total
FROM(
	 SELECT o.city, e.firstname 
	 FROM employees AS e
	 JOIN offices AS o
	 		USING(officecode)
	 WHERE firstName LIKE 'L%'
	 UNION ALL
	 SELECT city, customername
	 FROM customers AS c
	 WHERE c.customerName LIKE 'L%') AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

## NO 3
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Karyawan/Pelanggan', 
				 'Employee' AS `status`
FROM employees AS e
WHERE e.officeCode IN ( 
	SELECT officecode
	FROM employees
	GROUP BY officecode
	HAVING COUNT(*) = (
		SELECT officecode
		FROM employees 
		GROUP BY officecode
		ORDER BY COUNT(*)
		LIMIT 1)
)
UNION 
SELECT c.customername AS 'Nama Karyawan/Pelanggan', 'Customer' AS `status`
FROM customers AS C
JOIN employees AS e 
ON c.salesrepemployeenumber = e.employeeNumber
WHERE e.officeCode IN(
		SELECT officecode 
		FROM employees 
		GROUP BY officecode
		HAVING COUNT(*) = (
				SELECT officecode
				FROM employees 
				GROUP BY officecode
				ORDER BY COUNT(*)
				LIMIT 1)
) 
ORDER BY `Nama Karyawan/Pelanggan`;


## NO 4
SELECT tanggal, 
GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
	SELECT paymentDate AS tanggal, 
			 'membayar pesanan' AS riwayat 
	FROM payments
	WHERE MONTH(paymentDate) = 4 AND YEAR(paymentdate) = 2003
	UNION 
	SELECT orderdate AS tanggal, 
			 'memesan barang' AS riwayat
	FROM orders
	WHERE MONTH(orderdate) = 4 AND YEAR(orderdate)= 2003
	) AS datacustomers
GROUP BY tanggal
ORDER BY tanggal;
