use sakila;

-- 1
-- AL
select title, rating
from film
where title like 'R%R'
order by title;

-- 2
-- AL
select concat(a.first_name, ' ', a.last_name) 'nama_lengkap_actor',
		group_concat(f.title) 'daftar_film'
from actor a
join film_actor
using (actor_id)
join film f
using (film_id)
where a.last_name like 'A%'
group by a.actor_id;

-- 3
-- AL
(select concat(c.first_name, ' ', c.last_name) 'nama_customer',
		sum(p.amount) 'total_pengeluaran',
        case
			when sum(p.amount) >
				(select avg(`total`) from
					(select sum(p.amount) 'total'
                    from payment p
                    group by p.customer_id) as a
				) then 'beban orang tua'
			else 'rajin menabung'
		end 'status'
from customer c
join payment p
using (customer_id)
group by p.customer_id
order by `status`
limit 10)

union

(select concat(c.first_name, ' ', c.last_name) 'nama_customer',
		sum(p.amount) 'total_pengeluaran',
        case
			when sum(p.amount) >
				(select avg(`total`) from
					(select sum(p.amount) 'total'
                    from payment p
                    group by p.customer_id) as a
				) then 'beban orang tua'
			else 'rajin menabung'
		end 'status'
from customer c
join payment p
using (customer_id)
group by p.customer_id
order by `status` desc
limit 10);
