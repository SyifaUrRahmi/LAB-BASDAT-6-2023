#NO. 1 AMF
SELECT title, rating
FROM film 
WHERE title LIKE 's%s'
ORDER BY title DESC;

#NO. 2 JO
SELECT CONCAT (aktor FIRST.name, ' ', aktor LAST.name) nama_lengkap_aktor, GROUP_CONCAT (film.title) daftar_film
FROM film
JOIN film_aktor USING (film_id)
JOIN aktor USING (aktor_id) 
WHERE aktor.last_name LIKE 'a%'
GROUP BY aktor.aktor_id;

#NO. 3 NA
(SELECT concat(customer.first_name, ' ', customer.last_name) nama_customer, 
SUM(payment.amount) total_pengeluaran, 
case
when SUM(payment.amount) > (SELECT AVG(total) FROM (
	SELECT SUM(payment.amount) total
	FROM payment
	JOIN customer USING (customer_id)
	JOIN address USING (address_id)
	JOIN city USING (city_id)
	JOIN country USING (country_id)
	WHERE country.country = 'indonesia'
	GROUP BY customer.customer_id) AS AVG)
	then 'gaji di bawah rata-rata'
ELSE 'gaji di atas rata-rata'
END AS 'status'
FROM customer
JOIN payment USING (customer_id)
GROUP BY payment.customer_id
ORDER BY `status`
LIMIT 10)
UNION
(SELECT concat(customer.first_name, ' ', customer.last_name) nama_customer, 
SUM(payment.amount) total_pengeluaran, 
case
when SUM(payment.amount) > (SELECT AVG(total) FROM (
	SELECT SUM(payment.amount) total
	FROM payment
	JOIN customer USING (customer_id)
	JOIN address USING (address_id)
	JOIN city USING (city_id)
	JOIN country USING (country_id)
	WHERE country.country = 'indonesia'
	GROUP BY customer.customer_id) AS AVG)
	then 'gaji di bawah rata-rata'
ELSE 'gaji di atas rata-rata'
END AS 'status'
FROM customer
JOIN payment USING (customer_id)
GROUP BY payment.customer_id
ORDER BY `status` DESC
LIMIT 10);