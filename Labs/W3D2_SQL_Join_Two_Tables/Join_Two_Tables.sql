-- 1.How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT b.name as category_name, COUNT(a.film_id) as number_of_films 
FROM film_category a
LEFT JOIN  category b
	ON a.category_id = b.category_id
GROUP BY name;

-- 2. Which actor has appeared in the most films?
SELECT CONCAT(b.first_name, " ",b.last_name) AS actor_name, COUNT(a.film_id) AS number_of_films
FROM film_actor a
LEFT JOIN actor b
	ON a.actor_id = b.actor_id
GROUP BY actor_name
ORDER BY number_of_films DESC
LIMIT 1;

-- 3. Most active customer (the customer that has rented the most number of films)
SELECT CONCAT(b.first_name, " ",b.last_name) AS customer_name, COUNT(rental_id) AS number_of_rentals
FROM rental a
LEFT JOIN customer b
	ON a.customer_id = b.customer_id
GROUP BY customer_name
ORDER BY number_of_rentals DESC
LIMIT 1;

-- 4. List number of films per category.
SELECT b.name AS category_name, COUNT(a.film_id) AS number_of_films
FROM film_category a
LEFT JOIN category b
	ON a.category_id = b.category_id
GROUP BY category_name;

-- 5. Display the first and last names, as well as the address, of each staff member
SELECT DISTINCT a.first_name, a.last_name, b.address, b.district, c.city
FROM staff a
LEFT JOIN address b
	ON a.address_id = b.address_id
LEFT JOIN city c
	ON b.city_id = c.city_id;
    
-- 6.Display the total amount rung up by each staff member in August of 2005.
SELECT CONCAT(b.first_name, " ", b.last_name) AS staff_member, SUM(a.amount) AS rung_up_amount
FROM payment a
LEFT JOIN staff b
	ON a.staff_id = b.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY staff_member;

-- 7. List each film and the number of actors who are listed for that film.
SELECT c.title, COUNT(CONCAT(b.first_name, " ", b.last_name)) AS actors_in_film
FROM film_actor a
LEFT JOIN actor b
	ON a.actor_id = b.actor_id
LEFT JOIN film c
	ON a.film_id = c.film_id
GROUP BY c.title;

-- 8. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name. Bonus: Which is the most rented film? 
-- The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
SELECT CONCAT(b.last_name, " ", b.first_name) AS customer, SUM(a.amount) AS total_paid
FROM payment a
LEFT JOIN customer b
	ON a.customer_id = b.customer_id
GROUP BY customer
ORDER BY customer;

-- BONUS
SELECT d.title AS film, COUNT(a.rental_id) AS number_of_rentals
FROM payment a
LEFT JOIN rental b
	ON a.rental_id = b.rental_id
LEFT JOIN inventory c
	ON b.inventory_id = c.inventory_id
LEFT JOIN film d
	ON c.film_id = d.film_id
GROUP BY d.title
ORDER BY number_of_rentals DESC;