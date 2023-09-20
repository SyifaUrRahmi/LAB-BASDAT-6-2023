-- nomor 1
SELECT customerName, city, country FROM customers
WHERE country = 'usa';

-- nomor 2
SELECT DISTINCT productVendor FROM products;

-- nomor 3
SELECT*FROM payments
WHERE customerNumber = '124'
ORDER BY paymentDate DESC;

-- nomor 4
SELECT productName AS 'Nama produk', buyPrice AS 'Harga beli', quantityInStock AS 'Jumlah dalam stok'
FROM products
WHERE quantityInStock > 1000
AND quantityInstock < 3000
ORDER BY buyPrice
LIMIT 5,10;

-- nomor 5
SELECT country, creditLimit FROM customers
ORDER BY creditLimit DESC
LIMIT 2,1





