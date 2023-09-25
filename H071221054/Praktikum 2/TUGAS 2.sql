-- TUGAS 2
USE classicmodels;

-- NO 1
SELECT customerName, city, country 
FROM customers
WHERE country = 'usa';

-- NO 2
SELECT DISTINCT productVendor
FROM products;

-- NO 3
SELECT * FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC;

-- NO 4
SELECT productname AS 'Nama produk', buyprice AS 'Harga beli', quantityinstock AS 'Jumlah dalam stok'
FROM products
WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice
LIMIT 5,10;

-- NO5
SELECT country, creditLimit FROM customers ORDER BY creditLimit DESC LIMIT 2,1

