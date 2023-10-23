## Nomor 1
SELECT CONCAT ('jalan ', o.addressLine1, o.addressLine2, ' kota ', o.city, ' negara ', o.country) alamat
FROM offices o
JOIN employees e USING (officeCode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber IN (
SELECT customerNumber
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) = (
SELECT COUNT(*)
FROM payments
GROUP BY customerNumber
ORDER BY COUNT(*)
LIMIT 1)
);

## Nomor 2 
SELECT CONCAT(e.firstName, ' ', e.lastName) AS Karyawan,
  SUM(p.amount) AS Pendapatan,
  e.employeeNumber
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
USING (customerNumber)
WHERE e.employeeNumber IN (
  (SELECT e.employeeNumber FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber JOIN payments p USING (customerNumber) GROUP BY e.employeeNumber ORDER BY SUM(p.amount) DESC LIMIT 1), 
  (SELECT e.employeeNumber FROM employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber JOIN payments p USING (customerNumber) GROUP BY e.employeeNumber ORDER BY SUM(p.amount) LIMIT 1)
)
GROUP BY e.employeeNumber;

## Nomor 3
SELECT c.name negara,
	(cl.Percentage * c.Population) 'Pengguna bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode 
WHERE LANGUAGE = (SELECT cl.LANGUAGE 
						FROM countrylanguage cl
						JOIN country c
						ON c.Code = cl.CountryCode 
						WHERE Continent = 'asia'
						GROUP BY LANGUAGE
						ORDER BY COUNT(*) DESC 
						LIMIT 1
)


## Nomor 4
SELECT c.customerName,
   SUM(amount) as totalPayment, 
   SUM(od.quantityOrdered) as Total, 
   GROUP_CONCAT(p.productName SEPARATOR ', ') as productsPurchased
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
JOIN payments 
USING (customerNumber)
GROUP BY c.customerNumber
HAVING SUM(amount) > (SELECT AVG(TotalPaymentCustomer)
    							FROM (select SUM(amount) TotalPaymentCustomer
    							FROM payments
								GROUP BY customerNumber) totalPurchased)
;

## Nomor 5
SELECT 
   c.customerName, 
   p.productName
FROM customers AS C
JOIN payments AS py
USING (customerNumber)
JOIN orders AS  o 
USING (customerNumber)
JOIN orderdetails AS  od
USING (orderNumber)
JOIN products AS p 
USING (productCode)
WHERE creditLimit = (SELECT creditlimit
							FROM customers
							ORDER BY creditLimit DESC
							LIMIT 1) GROUP BY productName;
