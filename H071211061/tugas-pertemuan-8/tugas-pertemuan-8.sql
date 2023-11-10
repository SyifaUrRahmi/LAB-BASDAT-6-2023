#NOMOR 1
(SELECT customers.customerName, products.productName, 
(products.buyprice * SUM(orderdetails.quantityOrdered)) AS modal
FROM customers
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products
USING (productCode)
GROUP BY customers.customerNumber
ORDER BY `modal` DESC LIMIT 3)
UNION
(SELECT customers.customerName, products.productName, 
(products.buyprice * SUM(orderdetails.quantityOrdered)) AS modal
FROM customers
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products
USING (productCode)
GROUP BY customers.customerNumber
ORDER BY `modal` LIMIT 3);

#NOMOR 2
SELECT `Kota` FROM 
	(SELECT CONCAT(employees.firstName, ' ' ,employees.lastName) 
	AS "Nama Karyawan / Pelanggan", offices.city AS "Kota" 
	FROM employees
	INNER JOIN offices
	ON employees.officeCode = offices.officeCode
	WHERE employees.firstName LIKE "L%"
	UNION
	SELECT customerName, city AS "Kota" FROM customers
	WHERE customerName LIKE "L%") AS a
GROUP BY `Kota`
ORDER BY COUNT(`Nama Karyawan / Pelanggan`) DESC LIMIT 1;

#NOMOR 3
SELECT CONCAT(employees.firstName, ' ' ,employees.lastName) 
AS "Nama Karyawan/Pelanggan", 'karyawan' AS 'status' 
FROM employees
WHERE officeCode IN (SELECT officeCode
		      FROM employees
		      GROUP BY officeCode
		      HAVING COUNT(*) = (SELECT COUNT(*)
				          FROM employees
				          GROUP BY officeCode
				          ORDER BY COUNT(*) LIMIT 1))
UNION 
SELECT customerName, 'pelanggan' FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE employees.officeCode IN (SELECT officeCode
				  FROM employees
				  GROUP BY officeCode
				  HAVING COUNT(*) = (SELECT COUNT(*)
						      FROM employees
                                                  GROUP BY officeCode
                                                  ORDER BY COUNT(*) 
		                                    LIMIT 1))
ORDER BY `Nama Karyawan/Pelanggan`;

#NOMOR 4
SELECT `tanggal`, GROUP_CONCAT(`riwayat` SEPARATOR ' dan ') 
AS riwayat
FROM (SELECT DISTINCT 'memesan barang' AS riwayat, 
      orderDate as tanggal FROM orders
	WHERE YEAR(orderDate) = 2003 AND MONTH(orderDate) = 4
	UNION
	SELECT DISTINCT 'membayar pesanan' AS riwayat, 
      paymentDate AS tanggal FROM payments 
	WHERE YEAR(paymentDate) = 2003 AND MONTH(paymentDate) = 4
	) AS a
GROUP BY `tanggal`;

#NOMOR 5
SELECT 'tertinggi' AS 'status', MAX(quantityOrdered) 'jumlah' ,
productName
FROM orderdetails
JOIN products
USING (productCode)
UNION
SELECT 'terendah', MIN(quantityOrdered) 'jumlah' , productName
FROM orderdetails
JOIN products
USING (productCode)