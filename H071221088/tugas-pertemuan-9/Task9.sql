USE classicmodels;

-- nomor 1
SELECT YEAR(orderDate) AS Tahun, COUNT(orderNumber) AS JumlahPesanan,
		 CASE WHEN COUNT(orderNumber) > 150 THEN 'Banyak'
			   WHEN COUNT(orderNumber) < 75 THEN 'Sedikit'
			   ELSE 'Sedang'
	  	 END AS KategoriPesanan
FROM orders
GROUP BY YEAR(orderDate);

-- nomor 2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama pegawai', SUM(p.amount) AS 'gaji', 
	    CASE WHEN SUM(p.amount) > (SELECT AVG(total) 
								          FROM (SELECT SUM(amount) AS 'total' 
									             FROM customers
									           	 JOIN payments USING (customerNumber)
										          JOIN employees ON employeeNumber = salesRepEmployeeNumber
										          GROUP BY employeeNumber
													) AS a
											) THEN 'di atas rata-rata gaji'
				ELSE 'di bawah rata-rata gaji' 
	    END 'kategori gaji'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
USING (customerNumber)
GROUP BY e.employeeNumber
ORDER BY SUM(p.amount) DESC;


-- nomor 3
SELECT c.customerName 'Nama Pelanggan',
	    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
	    COUNT(p.productCode) 'Jumlah Produk',
       SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
       CASE WHEN MONTH(o.orderDate) % 2 = 1 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(`Total`) 
																							                        FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
																								                           FROM orders o2
																								                           GROUP BY customernumber
																																	) AS a
																							                       ) THEN 'TARGET 1'
			   WHEN MONTH(o.orderDate) % 2 = 0 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (SELECT AVG(`Total`) 
																							                        FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
																								                           FROM orders o2
																								   								GROUP BY customernumber
																																  ) AS a
																							                       ) THEN 'TARGET 2'
	    END 'Keterangan'
FROM customers c
JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
WHERE p.productName LIKE '18%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL

UNION

SELECT c.customerName 'Nama Pelanggan',
       GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
       COUNT(p.productCode) 'Jumlah Produk',
       SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
       CASE WHEN MONTH(o.orderDate) % 2 <> 0 AND COUNT(p.productCode) > 10 * (SELECT AVG(product_count)
																			                     FROM (SELECT COUNT(p2.productCode) AS product_count
																					                     FROM products p2
																					                     GROUP BY p2.productCode
																											  ) AS counts
																			                    ) THEN 'TARGET 3'
            WHEN MONTH(o.orderDate) % 2 = 0 AND COUNT(p.productCode) > 10 * (SELECT AVG(product_count)
																		                       FROM (SELECT COUNT(p2.productCode) AS product_count
																				                       FROM products p2
																				                       GROUP BY p2.productCode
																											 ) AS counts
																		                      )THEN 'TARGET 4'
       END 'Keterangan'
FROM customers c
JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
WHERE p.productName LIKE '19%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL
 	
UNION 

SELECT c.customerName 'Nama Pelanggan',
	    GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk',
       COUNT(p.productCode) 'Jumlah Produk',
       SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
	    CASE WHEN MONTH(o.orderDate) % 2 <> 0 AND COUNT(p.productCode) > 3 * (SELECT MIN(product_count)
																			                    FROM (SELECT COUNT(p2.productCode) AS product_count
																				                       FROM products p2
																				                       GROUP BY p2.productCode
																											 ) AS counts
																			                   ) THEN 'TARGET 5'
		      WHEN MONTH(o.orderDate) % 2 = 0 AND COUNT(p.productCode) > 3 * (SELECT MIN(product_count)
																			                   FROM (SELECT COUNT(p2.productCode) AS product_count
																				                      FROM products p2
																				                      GROUP BY p2.productCode
																											) AS counts
																		                     ) THEN 'TARGET 6'
       END 'Keterangan'
FROM customers c
JOIN orders o USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
WHERE productName LIKE '20%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL
ORDER BY `Keterangan` ASC 