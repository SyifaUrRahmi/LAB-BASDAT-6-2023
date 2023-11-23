-- Nomor 1
SELECT 	
	CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Karyawan',
	GROUP_CONCAT(o.ordernumber) AS 'Nomor Order',
	COUNT(o.ordernumber) AS 'Jumlah Pesanan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING (customernumber) 
GROUP BY c.salesRepEmployeeNumber
HAVING COUNT(o.orderNumber) > 10;

-- Nomor 2
SELECT 
	p.productCode, 
	p.productName, 
	p.quantityInStock, 
	o.orderDate
FROM products p
JOIN orderdetails od USING (productCode)
JOIN orders o USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY productCode
ORDER BY o.orderDate ASC;


-- Nomor 3
SELECT 
	o.addressLine1 AS 'Alamat',
	CONCAT(LEFT(o.phone, LENGTH(o.phone) - 5), '* **') AS 'Nomor Telp',
	COUNT(DISTINCT e.employeeNumber) AS 'Jumlah karyawan',
	COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
	ROUND(AVG(p.amount), 2) AS 'Rata rata penghasilan'
FROM offices o
LEFT JOIN employees e USING (officeCode)
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p USING (customerNumber)
GROUP BY o.phone;

-- Nomor 4
SELECT 
	c.customerName, 
	YEAR(o.orderDate) AS 'Tahun order',
	MONTHNAME(o.orderDate) AS 'Bulan order', 
	COUNT(od.quantityOrdered) AS 'Jumlah pesanan',
	SUM(od.quantityOrdered * od.priceEach) AS 'Uang total penjualan'
FROM products p
JOIN orderdetails od USING (productCode)
JOIN orders o USING (orderNumber)
JOIN customers c USING (customerNumber)
WHERE YEAR(orderDate) = 2003
GROUP BY customerName, YEAR(o.orderDate), MONTH(o.orderDate);

-- Soal Tambahan
SELECT 
    p.productName AS 'Nama Produk',
    COUNT(o.orderNumber) AS 'Jumlah di Order',
    GROUP_CONCAT(o.orderDate ORDER BY o.orderDate ASC SEPARATOR ', ') AS 'Waktu Orderan',
    p.buyPrice AS 'Harga Beli',
    od.priceEach AS 'Harga Jual',
    SUM(od.quantityOrdered) AS 'Total Kuantitas Orderan',
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS 'Keuntungan'
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE p.productName = '2001 Ferrari Enzo'
GROUP BY od.priceEach
HAVING (od.priceEach - p.buyPrice) * od.quantityOrdered > 5000
