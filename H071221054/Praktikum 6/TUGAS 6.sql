-- TUGAS PRAKTIKUM 6

USE classicmodels;

-- NO 1
SELECT CONCAT(e.firstName, ' ', e.lastName) 'Nama Employee', 
       GROUP_CONCAT(o.orderNumber) 'Nomor Orderan', 
       COUNT(o.orderNumber) 'Jumlah Pesanan'
FROM employees AS e
JOIN customers ON salesRepEmployeeNumber = e.employeeNumber
JOIN orders AS o USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;


-- NO 2
SELECT p.productCode, p.productName, p.quantityInStock, MIN(o.orderDate) 'orderDate'
FROM products AS p
JOIN orderdetails USING (productCode)
JOIN orders AS o USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode;

-- NO 3
-- SELECT * FROM offices;
-- SELECT * FROM customers;
-- SELECT * FROM employees;

SELECT 
	o.addressLine1 'Alamat', 
	CONCAT(LEFT(o.phone, (LENGTH(o.phone)-6)),'* ****') 'Nomor Telp',  
	COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan',
	COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan', 
	FORMAT(AVG(p.amount),2) 'Rata-Rata Penghasilan'
FROM offices AS o
JOIN employees AS e USING (officeCode)
left JOIN customers AS c ON c.salesRepEmployeeNumber = e.employeeNumber
left JOIN payments AS p USING (customerNumber)
GROUP BY officeCode
ORDER BY o.phone;


-- NO 4
-- SELECT * from orderdetails;

SELECT c.customerName, 
		 YEAR(o.orderDate) 'Tahun Order',
		 MONTH(o.orderDate) 'Bulan Order',
		 count(o.orderNumber) 'Jumlah Pesanan',
		 SUM(od.priceEach*od.quantityOrdered) 'Uang Total Penjualan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, MONTH(o.orderDate);


-- SOAL TAMBAHAN (NO 5)
SELECT UPPER(p.productName) 'Nama Produk', 
		 COUNT(o.orderNumber) 'Jumlah di Order', 
		 GROUP_CONCAT(o.orderDate SEPARATOR ', ') 'Waktu Orderan',
		 p.buyprice 'Harga Beli',
		 od.priceEach 'Harga Jual',
		 SUM(od.quantityOrdered) 'Total Jumlah Orderan',
		 CONCAT(od.priceEach * SUM(od.quantityOrdered), ' - ' ,p.buyprice * SUM(od.quantityOrdered), ' = ',
		 od.priceEach * SUM(od.quantityOrdered) - p.buyprice * SUM(od.quantityOrdered)) 'Pendapatan - Modal = Keuntungan'
FROM products AS p
JOIN orderdetails AS od USING (productCode)
JOIN orders AS o USING (orderNumber)
WHERE p.productName = '2001 ferrari enzo'
GROUP BY od.priceEach
HAVING(od.priceEach * SUM(od.quantityOrdered) - p.buyprice * SUM(od.quantityOrdered)) > 5000
ORDER BY (od.priceEach * SUM(od.quantityOrdered) - p.buyprice * SUM(od.quantityOrdered))





		 

