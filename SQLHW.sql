use sakila;
select first_name, last_name
from actor;

select concat(first_name," ", last_name) As "Actor Name"
from actor;

select actor_id, first_name, last_name
from actor
where first_name = "Joe";


select *
from actor
where last_name like "%GEN%";

select *
from actor
where last_name like "%LI%"
ORDER BY last_name, first_name;


SELECT country_id,  country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB(15) AFTER last_name;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, count(last_name) as 'Last_Name_Frequency'
FROM actor
group by last_name having `Last_Name_Frequency` >= 1;

SELECT last_name, count(last_name) as 'Last_Name_Frequency'
FROM actor
group by last_name having `Last_Name_Frequency` >= 2;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name="GROUCHO" and last_name="WILLIAMS";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name="HARPO" and last_name="WILLIAMS";

SHOW CREATE TABLE address;

SELECT first_name,last_name,address
FROM staff
INNER JOIN address ON (staff.address_id = address.address_id);

SELECT s.first_name,s.last_name,SUM(p.amount)
FROM staff s
INNER JOIN payment p ON (p.staff_id = s.staff_id)
WHERE MONTH(p.payment_date)=08 AND YEAR(p.payment_date)=2005
GROUP BY s.staff_id;

select f.title, COUNT(fa.actor_id) AS "actors"
from film_actor fa
INNER JOIN film f On(f.film_id=fa.film_id)
GROUP BY f.title;

SELECT title, COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

SELECT  first_name,last_name, SUM(amount)
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;

SELECT *
FROM film
WHERE language_id=1 AND (title LIKE "Q%" OR title LIKE "K%"); 

SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id FROM film_actor WHERE film_id 
		IN (SELECT film_id from film where title='ALONE TRIP'));

SELECT first_name, last_name, email 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city cit ON (a.city_id=cit.city_id)
JOIN country cntry ON (cit.country_id=cntry.country_id);

SELECT * 
from film 
JOIN film_category on (film.film_id=film_category.film_id)
JOIN category on (film_category.category_id=category.category_id)
WHERE name='Family';

SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

SELECT s.store_id, SUM(p.amount) 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;

SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

