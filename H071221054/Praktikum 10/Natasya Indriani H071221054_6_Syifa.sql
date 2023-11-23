-- TUGAS 10 (LIVE CODING) -  tahapan 2
USE sakila;

-- NO 1 AD
SELECT title 'Judul Film',
	    rating 'Rate',
		 release_year 'Tahun Rilis'
FROM film
WHERE rating > 3 AND release_year < 2015
ORDER BY release_year DESC
LIMIT 5;

-- NO 2 AMF
SELECT a.actor_id,
		 CONCAT(a.first_name, ' ', a.last_name) 'nama actor'
FROM actor AS a
JOIN film_actor USING (actor_id)
JOIN film AS f USING (film_id)
WHERE f.title LIKE '%love%'
GROUP BY actor_id;


-- NO 3 HA
SELECT c.customer_id,
		 CONCAT(c.first_name, ' ', c.last_name) 'customer name',
		 CASE
		 		WHEN SUM(py.amount) > (SELECT AVG(total)
		 									  FROM (SELECT SUM(py.amount) AS total
		 									  		  FROM customer AS c
		 									  		  JOIN payment AS py USING (customer_id)
		 									  		  JOIN address USING (address_id)
													  JOIN city USING (city_id)
													  JOIN country AS cy USING (country_id)
													  WHERE cy.country = 'indonesia'
		 									  		  GROUP BY c.customer_id) AS t)
		 THEN 'beban orang tua'
		 ELSE 'rajin menabung'
		 END AS 'tingkat keborosan'
FROM customer AS c
JOIN payment AS py USING (customer_id)
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country AS cy USING (country_id)
WHERE cy.country = 'indonesia'
GROUP BY c.customer_id

UNION

SELECT staff_id,
		 CONCAT(first_name, ' ', last_name) 'staff name',
		 'pekerja paruh waktu' status
FROM staff
GROUP BY staff_id;