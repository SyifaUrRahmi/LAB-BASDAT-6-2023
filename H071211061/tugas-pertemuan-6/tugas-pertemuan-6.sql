#1
SELECT CONCAT (e.firstName, ' ', e.lastName) 'nama employee',
GROUP_CONCAT(o.orderNumber SEPARATOR '; ') 'Nomor Orderan',
COUNT(o.customerNumber) AS Jumlahorderan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING(customerNumber)
GROUP BY e.employeeNumber
HAVING jumlahorderan > 10;

#2
SELECT p.productCode, p.productName, p.quantityInStock, (o.orderDate)
FROM products p
JOIN orderDetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productcode
having p.quantityInStock > 5000
ORDER BY orderDate ASC;

#3
SELECT
c.customerName,
YEAR(o.orderDate) 'tahun order',
GROUP_CONCAT(MONTHNAME(o.orderDate)) AS 'bulan order',
COUNT(od.orderNumber) AS 'pesanan',
SUM(od.priceEach * od.quantityOrdered) AS 'uang total pesanan'
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderDetails od ON o.orderNumber = od.orderNumber
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTHNAME(o.orderDate);

#4
SELECT of.addressLine1 AS 'Alamat', CONCAT(LEFT(of.phone, ((LENGTH(of.phone))-6)), '* **') AS 'Nomor Telp', 
COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan', COUNT(DISTINCT c.customerName) AS 'Jumlah Pelanggan', 
FORMAT(AVG(p.amount),2) AS 'Rata-rata Penghasilan' FROM employees AS e
LEFT JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber 
INNER JOIN offices AS of USING(officecode)
GROUP BY e.officeCode
ORDER BY of.phone;

#5
SELECT UPPER(products.productName) AS 'Nama Produk', 
COUNT(orders.orderDate) AS 'Jumlah di Order',
GROUP_CONCAT(orders.orderDate SEPARATOR ', ') AS 'Waktu Orderan',
products.buyPrice AS 'Harga Beli', 
orderdetails.priceEach AS 'Harga Jual', 
SUM(orderdetails.quantityOrdered) AS 'Total Jumlah Orderan',
CONCAT((orderdetails.priceEach * (SUM(orderdetails.quantityOrdered))), ' - ',
(products.buyPrice * (SUM(orderdetails.quantityOrdered))), ' = ' , 
(((orderdetails.priceEach * (SUM(orderdetails.quantityOrdered))) - 
((products.buyPrice * (SUM(orderdetails.quantityOrdered))))))) AS 'Pendapatan - Modal = Keuntungan'
FROM products
INNER JOIN orderdetails
ON products.productCode = orderdetails.productCode
INNER JOIN orders
ON orders.orderNumber = orderdetails.orderNumber
WHERE products.productName = '2001 Ferrari Enzo'
GROUP BY orderdetails.priceEach
HAVING (((orderdetails.priceEach * (SUM(orderdetails.quantityOrdered))) - 
((products.buyPrice * (SUM(orderdetails.quantityOrdered)))))) > 5000
ORDER BY ((orderdetails.priceEach - products.buyPrice) * (SUM(orderdetails.quantityOrdered)))