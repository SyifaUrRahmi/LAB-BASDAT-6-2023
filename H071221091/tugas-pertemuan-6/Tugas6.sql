USE classicmodels;

-- /No.1/
SELECT CONCAT(e.firstName,' ', e.lastName) AS 'nama employee',
		 GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan',
		 COUNT(o.orderNumber) AS 'Jumlah pesanan'
FROM employees AS e
JOIN customers AS c 
		ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o
		ON c.customerNumber = o.customerNumber
GROUP BY e.employeeNumber
HAVING COUNT(o.ordernumber) > 10;

-- /No.2/
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM orders AS o
JOIN orderdetails AS od
		USING (orderNumber)
JOIN products AS p
		USING (productCode)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate;

-- /No.3/
SELECT o.addressLine1 AS 'Alamat',
		 CONCAT(LEFT(o.phone, 6), '* **') AS 'Nomor Telp',
		 COUNT(DISTINCT e.employeeNumber) AS 'Jumlah karyawan',
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah pelanggan',
		 ROUND(AVG(p.amount), 2) AS 'Rata-rata Penghasilan'
FROM offices AS o
JOIN employees AS e
		USING (officeCode)
LEFT JOIN customers AS c
		ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
		USING (customerNumber)
GROUP BY o.addressLine1
ORDER BY o.phone;

-- /No.4/
SELECT c.customerName, 
		 YEAR(o.orderDate) AS 'Tahun Order', 
		 MONTHNAME(o.orderDate) AS 'Bulan Order', 
		 COUNT(o.orderNumber) AS 'Jumlah Pesanan', 
		 SUM(od.quantityOrdered * od.priceEach) AS 'Uang Total Penjualan'
FROM customers AS c
JOIN orders AS o
		USING (customerNumber)
JOIN orderdetails AS od
		USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, MONTHNAME(o.orderDate);


-- tugas tambahan
-- 
-- SELECT p.productName AS 'Nama Produk',
-- 		  
SELECT UPPER(p.productName) AS 'Nama Produk',
	    COUNT(o.orderNumber) AS 'Jumlah di Order',
	    GROUP_CONCAT(o.orderDate ORDER BY o.orderDate ASC SEPARATOR ', ') AS 'Waktu Orderan',
	    p.buyPrice AS 'Harga Beli',
	    od.priceEach AS 'Harga Jual',
	    SUM(od.quantityOrdered) AS 'Total Jumlah Orderan',
	    CONCAT((SUM(od.quantityOrdered) * od.priceEach), 
		 		' - ', 
		 		(SUM(od.quantityOrdered) * p.buyPrice),
				' = ',
	    		(SUM(od.quantityOrdered) * (od.priceEach - p.buyPrice))) AS 'pendapatan - modal = keuntungan'
FROM products p
JOIN orderdetails od 
		ON p.productCode = od.productCode
JOIN orders o 
		ON od.orderNumber = o.orderNumber
WHERE p.productName = '2001 Ferrari Enzo'
GROUP BY od.priceEach
HAVING SUM((od.quantityOrdered) * (od.priceEach - p.buyPrice)) > 5000
ORDER BY SUM(od.quantityOrdered) * (od.priceEach - p.buyPrice) ;

