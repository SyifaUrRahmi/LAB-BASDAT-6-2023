USE classicmodels;

-- No 1
SELECT customername, city, country
FROM customers
WHERE country = 'usa';

-- No 2
SELECT DISTINCT productvendor
FROM products;

-- No 3
SELECT customernumber, checknumber, paymentdate, amount
FROM payments
WHERE customernumber = 124
ORDER BY paymentdate DESC;

-- No 4
SELECT productname AS 'Nama Produk', buyprice AS 'Harga Beli', quantityinstock AS 'Jumlah dalam Stok'
FROM products
WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice ASC
LIMIT 5, 10;

-- N0 5 - Negara dengan limit ketiga terbesar.
SELECT customernumber, creditlimit, country
FROM customers
ORDER BY creditlimit DESC
LIMIT 2,1;