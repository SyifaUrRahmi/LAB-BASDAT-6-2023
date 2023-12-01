#1 MEDIUM
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.title AS film_list,
    COUNT(f.film_id) AS number_of_films,
    co.country
FROM
    customer AS c
    JOIN rental AS r 
	 	USING (customer_id)
    JOIN inventory AS i 
	 	USING (inventory_id)
    JOIN film AS f 
		USING (film_id) 	
    JOIN address AS a
		USING (address_id)
    JOIN city AS ci
		USING (city_id)
    JOIN country AS co 
		USING (country_id) 	
WHERE
    LENGTH(co.country) > LENGTH(REPLACE(co.country, ' ', '')) + 1
GROUP BY
   c.customer_id, co.country
ORDER BY
    film_list;
    
#2 MEDIUM
SELECT 
  f.title,
  f.special_features,
  GROUP_CONCAT(DISTINCT co.country ORDER BY co.country) AS country_list,
  COUNT(DISTINCT co.country) AS 'number of countries'
FROM 
  film f
  JOIN inventory i 
  	USING (film_id)
  JOIN rental r
   USING (inventory_id)
  JOIN customer c
   USING (customer_id)
  JOIN address a
   USING (address_id)
  JOIN city cy
   USING (city_id)
  JOIN country co
   USING (country_id)
WHERE  LENGTH(f.special_features) - LENGTH(REPLACE(f.special_features, ',', '')) + 1 = 3
GROUP BY f.film_id
HAVING COUNT(DISTINCT co.country) % 2 = 1;

#1 HARD
SELECT f.title, 
		 l.`name`AS 'language', 
		 c.name AS 'category', 
		 COUNT(fa.actor_id) AS 'total_actor', 
		 GROUP_CONCAT(CONCAT(a.first_name, " ", a.last_name)) AS 'actor_list'
FROM film AS f
JOIN language AS  l 
	USING(language_id)
JOIN film_category AS fc
	USING(film_id)
JOIN category AS C 
	USING(category_id)
JOIN film_actor AS fa 
	USING(film_id)
JOIN actor AS a 
	USING(actor_id)
WHERE f.film_id NOT IN (SELECT film_id	FROM inventory)
GROUP BY f.film_id
HAVING total_actor >= (SELECT AVG(total_actor) FROM 
	(SELECT film_id, COUNT(actor_id) AS total_actor
	        FROM film_actor
	      GROUP BY film_id) AS a)  
;

#3 HARD
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    GROUP_CONCAT(DISTINCT f.title) AS film_list,
    GROUP_CONCAT(DISTINCT f.length) AS duration_list,
    MAX(f.length) AS max_duration
FROM
    customer AS c
JOIN rental AS r 
	USING(customer_id)
JOIN inventory AS i 
	USING(inventory_id)
JOIN film AS f 
	USING(film_id)
WHERE
    LENGTH(REPLACE(CONCAT(c.first_name, c.last_name), 'L', '')) = LENGTH(CONCAT(c.first_name, c.last_name)) - 4
GROUP BY
    c.customer_id;