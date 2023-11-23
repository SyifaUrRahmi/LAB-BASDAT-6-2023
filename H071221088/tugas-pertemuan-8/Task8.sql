USE classicModels;

-- nomor 1
(SELECT c.customerName, p.productName, p.buyPrice* SUM(od.quantityOrdered) AS 'Modal'
FROM customers AS c
JOIN orders AS o USING(customerNumber)
JOIN orderdetails AS od USING(orderNumber)
JOIN products AS p USING(productCode)
GROUP BY c.customerName
ORDER BY p.buyPrice* SUM(od.quantityOrdered) DESC 
LIMIT 3)

UNION 

(SELECT c.customerName, p.productName, p.buyPrice*SUM(od.quantityOrdered)
FROM customers AS c
JOIN orders AS o USING(customerNumber)
JOIN orderdetails AS od USING(orderNumber)
JOIN products AS p USING(productCode)
GROUP BY c.customerName
ORDER BY p.buyPrice*SUM(od.quantityOrdered)
LIMIT 3);

-- nomor 2
(SELECT o.city, COUNT(e.employeeNumber)
FROM offices AS o
JOIN employees AS e USING(officeCode)
WHERE e.firstName LIKE 'L%'
GROUP BY o.city
ORDER BY COUNT(e.employeeNumber) DESC
LIMIT 1)

UNION 

(SELECT c.city, COUNT(c.customerNumber)
FROM customers AS c
WHERE c.contactFirstName LIKE 'L%'
GROUP BY c.city
ORDER BY  COUNT(c.customerNumber)
LIMIT 1)

SELECT city
FROM ((SELECT city, customerName, COUNT(*) AS total
		 FROM customers
		 WHERE customerName LIKE ('L%')
		 GROUP BY city
		 ORDER BY total DESC
	  	 LIMIT 1)
	  	 
UNION

(SELECT o.city, CONCAT(firstName,' ',lastName), COUNT(*) AS total
FROM employees e
JOIN offices USING (officeCode)
WHERE e.firstName LIKE ('L%') AND o.city = 'paris'
GROUP BY o.city
ORDER BY total
LIMIT 1)) AS total

GROUP BY city;

#3
SELECT CONCAT(firstName,' ',lastName) AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee_count)
        FROM (
            SELECT COUNT(*) AS employee_count
            FROM employees
            GROUP BY officeCode
        ) AS office_counts
    )
)
UNION ALL
SELECT customerName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee_count)
            FROM (
                SELECT COUNT(*) AS employee_count
                FROM employees
                GROUP BY officeCode
            ) AS office_counts
        )
    )
)
ORDER BY `nama karyawan/pelanggan`;

#4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS combined_data
GROUP BY tanggal
ORDER BY tanggal;