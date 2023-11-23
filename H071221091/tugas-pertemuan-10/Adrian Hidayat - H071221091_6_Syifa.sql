## NO 1 NA
USE sakila;

SELECT payment_id as 'id pembayaran',
	   rental_id as 'id sewa',
       payment_date as 'tanggal pembayaran'
FROM payment
WHERE payment_date > '2004'
ORDER BY payment_date DESC;


## NO 2 NI
SELECT f.title as 'Judul Film',
		COUNT(re.rental_id) as 'Jumlah Penyewaan',
		CONCAT(s.first_name,' ', s.last_name) as 'Nama Staff'
FROM rental as re
JOIN inventory as i 
	USING (inventory_id)
JOIN film as f 
	USING (film_id)
JOIN staff as s
	USING (staff_id)
WHERE DAYNAME (re.rental_date) = 'Sunday' AND f.title LIKE 'k%'
GROUP BY f.film_id
ORDER BY 'Jumlah Penyewaan' DESC;

## NO 3 AMF

(SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Nama_Pelanggan',
		GROUP_CONCAT(f.title) AS 'Judul_Film',
    	COUNT(r.rental_id) AS 'Jumlah_Peminjaman',
    	CASE WHEN COUNT(r.rental_id) > 32 
		 				THEN 'Sering Pinjam'
        	         ELSE 'Kadang Pinjam'
    	END AS Rental_Status
FROM customer AS C
JOIN rental AS r 
	USING (customer_id)
JOIN inventory AS i 
	USING (inventory_id)
JOIN film AS f 
	USING (film_id)
JOIN (SELECT customer_id
         FROM rental
         GROUP BY customer_id
         HAVING COUNT(rental_id) > (SELECT AVG(total_rental)
            				      FROM (SELECT COUNT(rental_id) AS total_rental
                				   FROM rental
                				   GROUP BY customer_id) AS subquery)
         ) AS frequent_renters ON c.customer_id = frequent_renters.customer_id
GROUP BY c.customer_id
ORDER BY Nama_pelanggan ASC
LIMIT 10)

UNION 

(SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Nama_Pelanggan',
		GROUP_CONCAT(f.title) AS 'Judul_Film',
    	COUNT(r.rental_id) AS 'Jumlah_Peminjaman',
    	CASE WHEN COUNT(r.rental_id) > 32 
		 				THEN 'Sering Pinjam'
        	         ELSE 'Kadang Pinjam'
    	END AS Rental_Status
FROM customer AS C
JOIN rental AS r 
	USING (customer_id)
JOIN inventory AS i 
	USING (inventory_id)
JOIN film AS f 
	USING (film_id)
JOIN (SELECT customer_id
         FROM rental
         GROUP BY customer_id
         HAVING COUNT(rental_id) > (SELECT AVG(total_rental)
            				      FROM (SELECT COUNT(rental_id) AS total_rental
                				   FROM rental
                				   GROUP BY customer_id) AS subquery)
         ) AS frequent_renters ON c.customer_id = frequent_renters.customer_id
GROUP BY c.customer_id
ORDER BY Nama_pelanggan ASC
LIMIT 10);