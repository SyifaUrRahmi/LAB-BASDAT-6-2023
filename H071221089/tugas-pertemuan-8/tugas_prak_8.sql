## Nomor 1
(SELECT c.customerName, p.ProductName, sum(od.quantityOrdered * od.priceEach) modal
FROM customers c
JOIN orders
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY customerNumber
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.ProductName, sum(od.quantityOrdered * od.priceEach) modal
FROM customers c
JOIN orders
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p 
USING (productCode)
GROUP BY customerNumber
ORDER BY modal
LIMIT 3);

## Nomor 2
SELECT `kota`
FROM (SELECT city AS kota, employeeNumber 'karyawan/pelanggan'
FROM employees
JOIN offices
USING (officeCode)
WHERE firstName LIKE 'L%'
UNION ALL
SELECT city, customerNumber
FROM customers
WHERE customerName LIKE 'L%') data
GROUP BY `kota`
ORDER BY COUNT(`karyawan/pelanggan`) DESC
LIMIT 1

## Nomor 3
SELECT customerName AS 'Nama Pelanggan/karyawan', 'Pelanggan' AS 'Status'
FROM customers
WHERE customerNumber IN (
    SELECT customerNumber
    FROM customers c
    JOIN employees e
    on c.salesRepEmployeeNumber = e.employeeNumber
    WHERE officeCode IN (SELECT officeCode
	    						FROM employees
	    						GROUP BY officeCode
	    						HAVING COUNT(*) = (SELECT MIN(employeescount)
	        												FROM (SELECT COUNT(*) AS employeescount
	            												FROM employees
	            												GROUP BY officeCode
	        														) AS officeemployees)
    )
)
UNION
SELECT CONCAT(firstName, ' ', lastName) AS 'Nama Karyawan', 'Karyawan' AS 'Status'
FROM employees
	WHERE officeCode IN (SELECT officeCode
	    						FROM employees
	    						GROUP BY officeCode
	    						HAVING COUNT(*) IN  (SELECT MIN(employeescount)
	        												FROM (SELECT COUNT(*) AS employeescount
	            												FROM employees
	            												GROUP BY officeCode
	        														) AS officeemployees)
) ORDER BY `Nama Pelanggan/karyawan`;

## Nomor 4
SELECT `Tanggal`, GROUP_CONCAT(`status` SEPARATOR ' dan ') AS riwayat
FROM (SELECT o.orderDate AS 'Tanggal', 'Memesan Barang' AS 'status'
	FROM customers c
	JOIN orders o
	USING (customerNumber)
	WHERE MONTH(o.orderDate) = 4 AND YEAR(o.orderDate) = 2003
	UNION 
	SELECT p.paymentDate AS 'Tanggal', 'Membayar Pesanan' AS 'status'
	FROM customers c
	JOIN payments p 
	USING (customerNumber)
	WHERE MONTH(p.paymentDate) = 4 AND YEAR(p.paymentDate) = 2003) data
	GROUP BY `Tanggal`

