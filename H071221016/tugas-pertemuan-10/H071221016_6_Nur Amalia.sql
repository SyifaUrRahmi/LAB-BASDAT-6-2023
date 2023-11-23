USE sakila

#1 HA

SELECT CONCAT(c.first_name,' ',c.last_name) AS 'Customer Name',
f.title AS 'Judul Film',
MONTH(r.rental_date) AS 'Bulan Penyewaan',
YEAR(r.rental_date) AS 'Tahun Penyewaan',
COUNT(r.rental_id) AS 'Jumlah Penyewaan'
FROM customer c
JOIN rental r
USING (customer_id)
JOIN inventory i
USING (inventory_id)
JOIN film f
USING (film_id)
WHERE LEFT(title,1) IN ('a','i','u','e','o')
GROUP BY f.film_id,c.customer_id,MONTH(r.rental_date)
HAVING COUNT(r.rental_date) = 2
ORDER BY `Jumlah Penyewaan` DESC 


#2HA

SELECT CONCAT(c.first_name,' ',c.last_name) AS 'Customer Name',
COUNT(r.rental_id) AS 'Jumlah Rental',
AVG(p.amount) AS 'Rata-Rata Pembayaran'
FROM customer c
JOIN rental r
USING (customer_id)
JOIN payment p
USING (rental_id)
JOIN address a
USING (address_id)
JOIN city cy
USING (city_id)
WHERE country_id % 2 = 1
GROUP BY c.customer_id
ORDER BY `Jumlah Rental` DESC  

#3NI

(SELECT
CONCAT(c.first_name, ' ', c.last_name) AS 'Nama Pelanggan',
COUNT(r.rental_id) AS 'Jumlah Rental',
SUM(py.amount) AS 'Total Pembayaran',
GROUP_CONCAT(DISTINCT MONTH(py.payment_date) SEPARATOR ', ') AS Bulan_Pembayaran,
    CASE
        WHEN DATE(r.rental_date) % 2 = 0 AND 
		       COUNT(r.rental_id) > (SELECT AVG(totalRental)
                                   FROM (SELECT COUNT(rental_id) AS totalRental
                                         FROM rental
                                         GROUP BY customer_id) AS rata_rataRental)
            AND LEFT(CONCAT(c.first_name, ' ', c.last_name), 1) IN ('a', 'i', 'u', 'e', 'o')
        THEN 'Kelompok 1'
        WHEN DATE(r.rental_date) % 2 = 1 AND
		  		 COUNT(r.rental_id) > (SELECT AVG(totalRental)
                                   FROM (SELECT COUNT(rental_id) AS totalRental
                                         FROM rental
                                         GROUP BY customer_id) AS rata_rataRental)
            AND LEFT(CONCAT(c.first_name, ' ', c.last_name), 1) IN ('a', 'i', 'u', 'e', 'o')
        THEN 'Kelompok 2'
    END AS Kategori_Pelanggan
FROM customer AS c
JOIN rental AS r USING (customer_id)
JOIN payment AS py USING (rental_id)
JOIN inventory AS i USING (inventory_id)
WHERE MONTH(py.payment_date) != 5
GROUP BY c.customer_id
HAVING Kategori_Pelanggan IS NOT NULL)
UNION
(SELECT
CONCAT(c.first_name, ' ', c.last_name) AS 'Nama Pelanggan',
COUNT(r.rental_id) AS 'Jumlah Rental',
SUM(py.amount) AS 'Total Pembayaran',
GROUP_CONCAT(DISTINCT month(py.payment_date) SEPARATOR ', ') AS Bulan_Pembayaran,
    CASE
        WHEN DATE(r.rental_date) % 2 = 0 AND 
		       SUM(py.amount) > (SELECT AVG(total)
                                  FROM (SELECT SUM(amount) AS total
                                        FROM payment
                                        GROUP BY rental_id) AS rata_rata)
            AND LEFT(CONCAT(c.first_name, ' ', c.last_name), 1) NOT IN ('a', 'i', 'u', 'e', 'o')
        THEN 'Kelompok 3'
        WHEN DATE(r.rental_date) % 2 = 1 AND
		  		 SUM(py.amount) > (SELECT AVG(total)
                                  FROM (SELECT SUM(amount) AS total
                                        FROM payment
                                        GROUP BY rental_id) AS rata_rata)
            AND LEFT(CONCAT(c.first_name, ' ', c.last_name), 1) NOT IN ('a', 'i', 'u', 'e', 'o')
        THEN 'Kelompok 4'
    END AS Kategori_Pelanggan
FROM customer AS c
JOIN rental AS r USING (customer_id)
JOIN payment AS py USING (rental_id)
JOIN inventory AS i USING (inventory_id)
WHERE MONTH(py.payment_date) != 2
GROUP BY c.customer_id
HAVING Kategori_Pelanggan IS NOT NULL);




















 


