use sakila;

-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT count(film_id) as number_of_copies
FROM inventory
WHERE film_id IN (SELECT film_id FROM film WHERE title="Hunchback Impossible");

-- 2.List all films whose length is longer than the average of all the films.
SELECT distinct title
FROM film
WHERE length > (SELECT avg(length) FROM film);

-- 3.Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = "Alone Trip"));
    
-- 4.Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (
SELECT category_id FROM category WHERE name IN("Animation", "Children", "Family")));

-- 5.Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys,
-- that will help you get the relevant information.
SELECT customer_id, first_name, last_name FROM customer WHERE address_id IN
(SELECT address_id FROM address WHERE city_id IN(
SELECT city_id FROM city WHERE country_id = (SELECT country_id FROM country WHERE country="Canada")));

SELECT customer_id, first_name, last_name
FROM customer a
JOIN address b
	ON a.address_id = b.address_id
JOIN city c
	ON b.city_id = c.city_id
JOIN country d
	ON c.country_id = d.country_id
WHERE d.country="Canada";

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor 
-- that has acted in the most number of films. First you will have to find the most prolific actor 
-- and then use that actor_id to find the different films that he/she starred.
SELECT title
FROM film
WHERE film_id IN(
SELECT film_id
FROM film_actor
WHERE actor_id = (
	SELECT actor_id 
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(actor_id) DESC
	LIMIT 1));
    
-- 7. Films rented by most profitable customer. You can use the customer table and payment table
--  to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT title
FROM film
WHERE film_id IN(
SELECT film_id
FROM inventory
WHERE inventory_id IN(
SELECT inventory_id
FROM rental WHERE customer_id=(SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1)));

-- 8. Customers who spent more than the average payments.
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN(
SELECT distinct customer_id
FROM payment
WHERE amount>(SELECT AVG(amount) FROM payment));



SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
SELECT customer_id
FROM payment 
GROUP BY customer_id
HAVING avg(amount)>(SELECT AVG(amount) FROM payment));


SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (SELECT customer_id FROM
(
SELECT customer_id, sum(amount) as total_paid
FROM payment
GROUP BY customer_id
HAVING total_paid >
(
SELECT sum(total_paid)/count(distinct(customer_id))
FROM
(SELECT customer_id, sum(amount) as total_paid
FROM payment
GROUP BY customer_id) as sum_table)) as table_to_select_customer_ids);