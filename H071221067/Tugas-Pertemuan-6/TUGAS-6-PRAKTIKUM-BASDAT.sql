USE classicmodels;

-- 1.
SELECT CONCAT(e.firstName, " ", e.lastName) 'Nama Employee',
		 o.orderNumber 'Nomor Orderan',
		 COUNT(e.employeeNumber) 'Jumlah Pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customernumber)
GROUP BY e.employeeNumber
HAVING COUNT(e.employeeNumber) > 10;

-- 2.
SELECT p.productCode,
		 p.productName,
		 p.quantityInStock,
		 MIN(o.orderDate) 'orderDate'
FROM products p
JOIN orderdetails od
USING (productcode)
JOIN orders o
USING (ordernumber)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000;

-- 3.
SELECT o.addressLine1 'Alamat',
		 CONCAT(LEFT(o.phone, LENGTH(o.phone) - 6), '* ****') 'Nomor Telp',
		 COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan',
		 COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan',
		 AVG(p.amount)
FROM offices o
LEFT JOIN employees e
USING (officecode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
USING (customernumber)
GROUP BY o.officeCode
ORDER BY o.phone;

-- 4.
SELECT c.customerName,
		 YEAR(o.orderDate) 'Tahun Order',
		 MONTHNAME(o.orderDate) 'Bulan Order',
		 COUNT(od.orderNumber) 'Jumlah Pesanan',
		 SUM(od.priceEach * od.quantityOrdered) 'Uang Total Penjualan'
FROM customers c
JOIN orders o
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName,
			MONTHNAME(o.orderDate);
			
-- 5.
SELECT UPPER(p.productName) 'Nama Produk',
		 COUNT(*) 'Jumlah di Order',
		 GROUP_CONCAT(o.orderDate SEPARATOR ", ") 'Waktu Orderan',
		 p.buyPrice 'Harga Beli',
		 od.priceEach 'Harga Jual',
		 SUM(od.quantityOrdered) 'Total Jumlah Orderan',
		 CONCAT(SUM(od.quantityOrdered) * od.priceEach, ' - ', 
		 		SUM(od.quantityOrdered) * p.buyPrice, ' = ', 
				(SUM(od.quantityOrdered) * od.priceEach - SUM(od.quantityOrdered) * p.buyPrice)) 
				'Pendapatan - Modal = Keuntungan'
FROM products p
LEFT JOIN orderdetails od
USING (productcode)
LEFT JOIN orders o
USING (ordernumber)
WHERE p.productName = '2001 Ferrari Enzo'
GROUP BY od.priceEach
HAVING (SUM(od.quantityOrdered) * od.priceEach - SUM(od.quantityOrdered) * p.buyPrice) > 5000
ORDER BY (SUM(od.quantityOrdered) * od.priceEach - SUM(od.quantityOrdered) * p.buyPrice);