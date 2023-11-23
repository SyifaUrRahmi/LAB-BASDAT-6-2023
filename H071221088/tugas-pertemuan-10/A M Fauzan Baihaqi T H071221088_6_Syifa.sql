use sakila;

-- Nomor 1 AF
select actor.actor_id, 
       concat(actor.first_name, ' ',actor.last_name) as actor_name, 
	   count(film_category.film_id) as film_count
from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film_category on film_actor.film_id = film_category.film_id
join category on film_category.category_id = category.category_id 
where category.name = 'Action'
group by actor.actor_id
order by film_count desc
limit 3;

-- Nomor 2 AF
select customer.customer_id, 
	   concat(customer.first_name, ' ', customer.last_name) as customer_name
from customer
left join (select rental.customer_id
		   from rental
		   join inventory on rental.inventory_id = inventory.inventory_id 
		   join film_category on inventory.film_id = film_category.film_id 
		   where film_category.category_id in (select category_id
											   from category
											   where name in ('Action', 'Comedy'))
		  )as rentalan on customer.customer_id = rentalan.customer_id
where rentalan.customer_id is null
order by customer.customer_id
limit 5;

-- Nomor 3 AF
(select  concat(actor.first_name, ' ', actor.last_name) as 'aktor',
		 group_concat(film.title) as 'judul film',
		 count(film.title) as 'jumlah film',
		 case when count(film.title) > 40 then 'senior'
			  when count(film.title) >= 20 then 'berpengalaman'
			  else 'pemula'
		 end as'kategori'
from film
join film_actor using (film_id)
join actor using (actor_id)
group by actor.actor_id
order by aktor
limit 10)
UNION
(select concat(actor.first_name, ' ', actor.last_name) as 'aktor', 
		group_concat(film.title) as 'judul film',
		count(film.title) as 'jumlah film',
		case when count(film.title) > 40 then 'senior' 
			 when count(film.title) >= 20 then 'berpengalaman' 
			 else 'pemula'
		end as 'kategori'
from film
join film_actor using (film_id)
join actor using (actor_id)
group by actor.actor_id
order by aktor desc
limit 10);