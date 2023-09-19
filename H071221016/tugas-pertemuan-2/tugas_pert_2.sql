USE classicmodels;
--- nomor 1 ---
SELECT customername,city,country FROM customers WHERE country = 'USA';
--- nomor 2 ---
SELECT DISTINCT productvendor FROM products;
--- nomor 3 ---
SELECT customernumber,checknumber,paymentdate,amount FROM payments WHERE customernumber = 124 ORDER BY paymentdate DESC ;
-- SELECT productname,buyprice,quantityinstock FROM products;
--- nomor 4 ---
SELECT productname AS 'Nama produk',buyprice AS 'Harga beli',quantityinstock AS 'Jumlah dalam stok' FROM products WHERE quantityinstock >= 1000 
AND quantityinstock <= 3000 ORDER BY buyprice ASC LIMIT 5,10;
--- soal tambahan---
SELECT *  FROM employees; 
SELECT employeenumber FROM employees WHERE lastname = 'bondur' AND firstname = 'gerard' ;
SELECT lastname,reportsto FROM employees WHERE reportsto = 1102;
