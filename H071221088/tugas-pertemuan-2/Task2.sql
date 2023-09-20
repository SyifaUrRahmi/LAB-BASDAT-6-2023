- Nomor 1
SELECT customerName, city, country
FROM customers
WHERE country = 'USA'

- Nomor 2
SELECT DISTINCT productVendor FROM products

- Nomor 3
SELECT *
FROM payments
WHERE customerNumber = 124
ORDER BY paymentDate DESC

- Nomor 4
SELECT productName 'nama produk', buyPrice 'harga beli', quantityinstock 'jumlah dalam stock'
FROM products
WHERE quantityinstock>1000 AND quantityinstock<3000
ORDER BY buyPrice
LIMIT 5,10

- Nomor 5
SELECT country, creditlimit
FROM customers
ORDER BY creditlimit DESC
LIMIT 2,1

- Nomor 6
SELECT employeeNumber, firstName, lastName FROM employees
WHERE firstName = 'Gerard' AND lastname = 'Bondur';

SELECT * FROM employees
WHERE reportsTo = 1102

