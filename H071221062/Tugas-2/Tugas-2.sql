USE classicmodels

SELECT customername, city, country FROM customers
WHERE country = 'usa';

SELECT DISTINCT productvendor FROM products;

SELECT customernumber, checknumber, paymentdate, amount FROM payments
WHERE customernumber = 124
ORDER BY paymentdate DESC


SELECT productname AS 'Nama Produk', buyprice AS 'Harga beli', quantityinstock AS 'Jumlah dalam stok'
FROM products
WHERE quantityinstock >1000 AND quantityinstock <3000
ORDER BY quantityinstock
LIMIT 5,10;

SELECT country, creditlimit FROM customers
ORDER BY creditlimit2
LIMIT ,1;