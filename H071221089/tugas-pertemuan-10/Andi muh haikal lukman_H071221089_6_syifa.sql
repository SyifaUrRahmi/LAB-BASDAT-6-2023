# 1
# jo
SELECT title 'Judul Film',
	GROUP_CONCAT(first_name , ', ', last_name) 'Nama Aktor'
FROM film
JOIN film_actor
USING (film_id)
JOIN actor a
USING (actor_id)
JOIN film_category
USING (film_id)
JOIN category c
USING (category_id)
WHERE rental_duration > 4
AND c.name = 'foreign'
GROUP BY film_id

#2
#AD
SELECT CONCAT(first_name , ' ', last_name) 'Nama Aktor',
	title 'Judul Film'
FROM film
JOIN film_actor
USING (film_id)
JOIN actor a
USING (actor_id)
WHERE last_name LIKE 's%' 
GROUP BY actor_id 

#3
#AD
(SELECT f.title AS 'judul film',
	f.release_year AS 'tahun rilis',
   GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name)) AS 'nama aktor',
   case 
	when f.film_id NOT IN (SELECT film_id
	FROM inventory) then 'Not Rented'
ELSE 'Rented'
END AS 'status Peminjaman'
FROM film f
JOIN film_actor 
USING (film_id)
JOIN actor a
USING (actor_id)
GROUP BY f.film_id
ORDER BY 'status Peminjaman'
LIMIT 10)
UNION
(SELECT f.title AS 'judul film',
   f.release_year AS 'rilis',
   GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name)) AS 'nama aktor',
   case 
	when f.film_id NOT IN (SELECT film_id
	FROM inventory) then 'Not Rented'
   ELSE 'Rented'
   END AS 'status Peminjaman'
FROM film f
JOIN film_actor 
USING (film_id)
JOIN actor a
USING (actor_id)
GROUP BY f.film_id
ORDER BY 'status Peminjaman' DESC
LIMIT 10);

