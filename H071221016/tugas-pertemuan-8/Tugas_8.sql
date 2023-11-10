USE classicmodels;

#nomor 1
(SELECT customers.customerName,products.productName,
(products.buyPrice* SUM(orderdetails.quantityOrdered)) AS 'modal'
FROM customers
JOIN  orders
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode) 
GROUP BY customers.customerName
ORDER BY modal DESC LIMIT 3)
UNION 
(SELECT customers.customerName,products.productName,
(products.buyPrice * SUM(orderdetails.quantityOrdered)) AS 'modal'
FROM customers
JOIN  orders
USING (customernumber)
JOIN orderdetails
USING (ordernumber)
JOIN products
USING (productcode) 
GROUP BY customers.customerName
ORDER BY modal ASC LIMIT 3);



#nomor 2
SELECT city, COUNT(*) AS jumlah_karyawan_pelanggan_L
FROM (
    SELECT offices.city FROM employees
    JOIN offices USING(officeCode)
    WHERE firstName LIKE 'L%'
    UNION ALL
    SELECT city FROM customers
    WHERE customername LIKE 'L%'
) AS merged_data
GROUP BY city
ORDER BY jumlah_karyawan_pelanggan_L DESC
LIMIT 1;

#nomor 3


SELECT firstName AS 'nama karyawan/pelanggan', 'Karyawan' AS status
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
SELECT contactFirstName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
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



#nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat1 SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal,('memesan barang') AS riwayat1
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal,('membayar pesanan')
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS a_data
GROUP BY tanggal;

# Soal Tambahan

(SELECT customers.customerName,customers.city,'Inisial A' AS inisial
FROM customers 
WHERE LEFT(customerName, 1) IN ('a')
LIMIT 2)
UNION 
(SELECT customers.customerName,customers.city,'Inisial B' AS inisial
FROM customers 
WHERE LEFT(customerName, 1) IN ('b')
LIMIT 2)
UNION
(SELECT customers.customerName,customers.city,'Inisial C' AS inisial
FROM customers 
WHERE LEFT(customerName, 1) IN ('c')
LIMIT 2)
UNION
(SELECT customers.customerName,customers.city,'Inisial D' AS inisial
FROM customers 
WHERE LEFT(customerName, 1) IN ('d')
LIMIT 2);


