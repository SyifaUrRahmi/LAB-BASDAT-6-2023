SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawan,
    GROUP_CONCAT(o.orderNumber) AS NomorOrderan,
    COUNT(o.orderNumber) AS JumlahPesanan
FROM employees AS e
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
GROUP BY employeenumber
HAVING JumlahPesanan > 10

SELECT
    p.productCode,
    p.productName,
    p.quantityInStock,
    o.orderDate
FROM products AS p
JOIN orderdetails AS od 
ON p.productCode = od.productCode
JOIN orders AS o 
ON od.orderNumber = o.orderNumber
WHERE p.quantityInStock > 5000
GROUP BY p.productcode
ORDER BY o.orderdate


SELECT
    o.addressLine1 AS Alamat,
    CONCAT(LEFT(o.phone, LENGTH(o.phone) - 6), 'X XXXX') AS NoTelp,
    COUNT(DISTINCT e.employeeNumber) AS JumlahKaryawan,
    COUNT(DISTINCT c.customerNumber) AS JumlahPelanggan,
   FORMAT(AVG(p.amount),2) AS RataRataPenghasilan
FROM offices AS o
JOIN employees AS e 
ON o.officeCode = e.officeCode
left JOIN customers AS c 
ON c.salesRepEmployeeNumber = e.employeenumber
left JOIN payments AS p 
ON c.customerNumber = p.customerNumber
GROUP BY o.officecode


SELECT
    c.customerName AS CustomerName,
    YEAR(o.orderDate) AS TahunOrder,
    MONTHNAME(o.orderDate) AS BulanOrder,
    COUNT(o.orderNumber) AS JumlahPesanan,
    SUM(od.priceEach*quantityordered) AS UangTotalPenjualan
FROM customers AS c
JOIN orders AS o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od 
ON o.orderNumber = od.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.CustomerNumber, BulanOrder 

SELECT
	UPPER(p.productname) AS Nama_Produk,
	COUNT(o.orderdate) AS jumlah_diorder,
	GROUP_CONCAT(o.orderdate) AS waktu_orderan,
	p.buyprice AS harga_beli,
	od.priceeach AS harga_jual,
	od.quantityordered AS totalJumlahOrderan
	(od.priceeach-p.buyprice)*SUM(od.quantityordered) 'Pendapatan-modal = keuntungan'
	FROM orderdetails od
	JOIN products p
	USING(productcode)
	JOIN orders o
	USING(ordernumber)
	WHERE p.productname = '2001 Ferrari Enzo'
	GROUP BY od.priceEach
	GROUP BY od.priceeach
	
	

