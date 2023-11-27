-- 1

(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal
LIMIT 3);

-- 2

SELECT `city`
FROM
(SELECT city AS 'city' customernumber AS 'a'
FROM customers
WHERE customerName LIKE ('L%')
GROUP BY city
ORDER BY total DESC
LIMIT 1)
UNION
(SELECT city, e.employeenumber
FROM employees e
JOIN offices o
USING (officeCode)
WHERE e.firstName LIKE ('L%')
GROUP BY o.city
ORDER BY total
LIMIT 1)
) AS total
GROUP BY city
ORDER BY COUNT(`a`)

-- 3

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
            SELECT MIN(employee)
            FROM (
                SELECT COUNT(*) AS employee
                FROM employees
                GROUP BY officeCode
            ) AS office
        )
    )
)
UNION
SELECT firstName AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee)
        FROM (
            SELECT COUNT(*) AS employee
            FROM employees
            GROUP BY officeCode
        ) AS office
    )
)
ORDER BY `nama karyawan/pelanggan`;

-- 4

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