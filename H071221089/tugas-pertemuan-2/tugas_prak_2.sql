-- nomor 1
SELECT customerName, city, country FROM customers 
WHERE country = 'USA'

-- nomor 2
SELECT DISTINCT productVendor FROM products

-- nomor 3
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments
WHERE customerNumber = 124 
ORDER BY paymentDate DESC 

-- nomor 4
SELECT productname AS `Nama produk`, buyPrice AS `Harga beli` , quantityinstock AS `Jumlah dalam stok` FROM  products 
WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY `Harga beli`
LIMIT 5,10;

-- nomor 5
SELECT * FROM employees
WHERE firstname = 'gerard' AND lastname = 'bondur';

SELECT * FROM employees
WHERE reportsTo = 1102;
