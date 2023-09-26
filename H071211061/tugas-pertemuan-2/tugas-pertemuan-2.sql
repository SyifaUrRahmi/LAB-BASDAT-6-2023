SELECT customername, city, country FROM customers WHERE country = 'USA';

SELECT distinct productvendor FROM products;

SELECT* FROM payments WHERE customernumber = 124 ORDER BY paymentdate DESC;

SELECT productname AS 'nama produk', buyprice 'harga beli', quantityinstock 'jumlah dalam stock' FROM products WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice
LIMIT 5, 10;

SELECT* FROM employees;
SELECT distinct jobTitle FROM employees
       
