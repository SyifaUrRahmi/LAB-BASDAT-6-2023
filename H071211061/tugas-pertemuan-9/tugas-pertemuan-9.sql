#NOMOR 1
SELECT YEAR(orderdate) tahun, COUNT(ordernumber) 'jumlah pesanan',
CASE
WHEN COUNT(ordernumber) > 150 THEN 'banyak pesanan'
WHEN COUNT(ordernumber) < 75 THEN 'sedikit'
ELSE 'sedang'
END AS 'kategori pesanan'
FROM orders
GROUP BY tahun
ORDER BY `jumlah pesanan` DESC;

#NOMOR 2
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'nama pegawai', SUM(p.amount) gaji,
CASE
WHEN SUM(p.amount) >= (SELECT AVG(total) FROM (SELECT SUM(payments.amount) total FROM employees 
JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber 
JOIN payments USING(customernumber) GROUP BY employeenumber) AS table_total) THEN 'gaji di atas rata-rata'
ELSE 'gaji di bawah rata-rata'
END AS 'kategori gaji'
FROM employees e JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customernumber)
GROUP BY employeenumber
ORDER BY gaji DESC;

#NOMOR 3
(SELECT 
  customername 'Pelanggan', 
  GROUP_CONCAT(LEFT(productname,4)) 'Tahun_Pembuatan', 
  COUNT(productname) 'Jumlah Produk',
  SUM(DATEDIFF(shippeddate, orderdate)) 'Total Durasi Pengiriman',
  CASE
    WHEN MONTH(orderdate) % 2 = 1 AND 
         SUM(DATEDIFF(shippeddate, orderdate)) > (SELECT AVG(total)
                                                   FROM (SELECT SUM(DATEDIFF(shippeddate, orderdate)) AS total
                                                         FROM orders
                                                         GROUP BY customernumber) AS selisih) THEN  'Target 1'
    WHEN MONTH(orderdate) % 2 = 0 AND 
         SUM(DATEDIFF(shippeddate, orderdate)) > (SELECT AVG(total)
                                                   FROM (SELECT SUM(DATEDIFF(shippeddate, orderdate)) AS total
                                                         FROM orders
                                                         GROUP BY customernumber) AS selisih) THEN 'Target 2'
  END AS `Keterangan`
FROM customers
JOIN orders USING (customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING (productcode)
WHERE LEFT(productname, 4) LIKE '18%' 
GROUP BY customernumber
HAVING `Keterangan` IS NOT NULL )

UNION 

(SELECT 
  customername 'Pelanggan', 
  GROUP_CONCAT(LEFT(productname,4)) 'Tahun_Pembuatan', 
  COUNT(productname) 'Jumlah Produk',
  SUM(DATEDIFF(shippeddate, orderdate)) 'Total Durasi Pengiriman',
  CASE
    WHEN MONTH(orderdate) % 2 = 1 AND 
         COUNT(productname) > (SELECT AVG(total)*10
                                                FROM (SELECT COUNT(productname) AS total
                                                         FROM products
                                                         GROUP BY productcode) AS selisih) THEN 
         'Target 3'
    WHEN MONTH(orderdate) % 2 = 0 AND 
        				COUNT(productname) > (SELECT AVG(total)*10
                                                   FROM (SELECT COUNT(productname) AS total
                                                         FROM products
                                                         GROUP BY productcode) AS selisih) THEN  'Target 4'
  END AS Keterangan
FROM customers
JOIN orders USING (customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING (productcode)
WHERE LEFT(productname, 4) LIKE '19%'
GROUP BY customernumber
HAVING `Keterangan` IS NOT NULL )

UNION 

(SELECT 
  customername 'Pelanggan', 
  GROUP_CONCAT(LEFT(productname,4)) 'Tahun_Pembuatan', 
  COUNT(productname) 'Jumlah Produk',
  SUM(DATEDIFF(shippeddate, orderdate)) 'Total Durasi Pengiriman',
  CASE
    WHEN MONTH(orderdate) % 2 = 1 AND 
         COUNT(productname) > (SELECT MIN(total)*3
                                                FROM (SELECT COUNT(productname) AS total
                                                         FROM products
                                                         GROUP BY productcode) AS selisih) THEN 
         'Target 5'
    WHEN MONTH(orderdate) % 2 = 0 AND 
        				COUNT(productname) > (SELECT MIN(total)*3
                                                   FROM (SELECT COUNT(productname) AS total
                                                         FROM products
                                                         GROUP BY productcode) AS selisih) THEN  'Target 6'
  END AS Keterangan
FROM customers
JOIN orders USING (customernumber)
JOIN orderdetails USING (ordernumber)
JOIN products USING (productcode)
WHERE LEFT(productname, 4) LIKE '20%'
GROUP BY customernumber
HAVING `Keterangan` IS NOT NULL )
ORDER BY keterangan