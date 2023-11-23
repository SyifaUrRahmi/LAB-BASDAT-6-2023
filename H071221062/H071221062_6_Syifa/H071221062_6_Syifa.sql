#1 NI
SELECT title AS 'judul film', `description` AS 'Deskripsi Film', rental_duration AS 'Durasi rental'
FROM film
WHERE rating = 'G' AND rental_duration BETWEEN 3 AND 6
ORDER BY rental_duration DESC
LIMIT 4,7;

#2 NA
SELECT c.customer_id AS 'ID Pelanggan', 
CONCAT(c.first_name, ' ' , c.last_name) AS 'Nama Pelanggan', 
CONCAT(a.postal_code,' ',cy.city_id,' ', ct.country_id) AS 'Alamat Lengkap'
FROM customer c
JOIN address a
USING(address_id)
JOIN city cy
USING(city_id)
JOIN country ct
USING(country_id)
WHERE a.postal_code IS NOT NULL AND cy.city_id IS NOT NULL AND ct.country_id IS NOT NULL 
GROUP BY c.customer_id;

#3 JO
SELECT
GROUP_CONCAT(f.title) 'Judul Film',
c.name 'Genre',
ROUND(SUM(f.rental_duration) / 60, 2) 'Total Durasi Rental',
CASE
WHEN
SUM(f.rental_duration) % 2 = 1 AND
SUM(f.rental_duration) > (
SELECT AVG(`Total`)
FROM (SELECT SUM(f2.rental_duration) 'Total'
FROM film f2
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
GROUP BY c.category_id) AS a
) THEN 'Unggulan 1'
SUM(f.rental_duration) % 2 = 0 AND
SUM(f.rental_duration) > (
SELECT AVG(`Total`)
FROM (SELECT SUM(f2.rental_duration) 'Total'
FROM film f2
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
GROUP BY (c.category_id) AS a
) THEN 'Unggulan 2'
END 'kriteria'
FROM film f2
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
GROUP BY (c.category_id) AS a
HAVING `Kriteria` IS NOT NULL
