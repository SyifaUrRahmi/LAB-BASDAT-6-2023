## Nomor 1
SELECT CONCAT (e.firstName, ' ' ,e.lastName) 'nama employee',
	GROUP_CONCAT(o.orderNumber) 'Nomor Orderan',
	COUNT(o.orderNumber) 'Jumlah Orderan'
FROM employees e
JOIN customers c 
	ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

## Nomor 2
SELECT p.productCode , 
   p.productName , 
   p.quantityInStock, 
   o.orderDate 
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o 
USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode, p.productName;

## Nomor 3
select o.addressLine1 'Alamat', 
concat(substring(o.phone, 1, length(o.phone) - 6), '* ****') 'Nomor Telp',  
count(distinct e.employeeNumber) 'Jumlah Karyawan', 
count(distinct c.customerNumber) 'Jumlah Pelanggan', 
format(avg(amount), 2) 'Rata-rata Penghasilan' 
from offices o
join employees e 
using (officeCode)
left join customers c 
on c.salesRepEmployeeNumber = e.employeeNumber
left join payments p 
using (customerNumber)
group by o.officecode
ORDER BY o.phone;

## Nomor 4
SELECT 
   c.customerName , 
   YEAR(o.orderDate) 'Tahun order', 
   MONTHNAME(o.orderDate) 'Bulan order', 
   COUNT(od.orderNumber) 'Jumlah pesanan', 
   SUM(od.priceEach * od.quantityOrdered) 'uang total pesanan'
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTHNAME(o.orderDate);

## Nomor 5
SELECT 
   UPPER(p.productName) 'Nama Produk',
   COUNT(o.orderNumber) 'Jumlah di Order',
   GROUP_CONCAT(o.orderDate) 'Waktu Orderan',
   p.buyPrice 'Harga Beli',
   od.priceEach 'Harga Jual',
   SUM(od.quantityOrdered) 'Total Jumlah Orderan',
   CONCAT ((od.priceEach * SUM(od.quantityOrdered)), ' - ',(p.buyPrice * SUM(od.quantityOrdered)), ' = ', (od.priceEach - p.buyPrice) * SUM(od.quantityOrdered)) 'Keuntungan Bersih'
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o 
USING (orderNumber)
WHERE p.productName = '2001 Ferrari Enzo' 
GROUP BY od.priceEach
HAVING ((od.priceEach - p.buyPrice) * SUM(od.quantityOrdered)) > 5000
ORDER BY (od.priceEach - p.buyPrice) * SUM(od.quantityOrdered) DESC ;
