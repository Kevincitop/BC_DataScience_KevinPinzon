# ----- INICIALIZACION DE LA BD -----
USE sakila;

# ----- PUNTO NO. 1 --------

SELECT first_name, last_name  FROM customer;

SELECT * FROM film
WHERE length >= 120;

# ----- PUNTO NO. 2 --------

SELECT * FROM customer 
ORDER BY last_name ASC;

SELECT * FROM film 
ORDER BY length DESC
LIMIT 5; # Existe una piramide de clausulas, el limit no se puede anteponer a 

# ----- PUNTO NO. 3 --------

SELECT customer.first_name, customer.last_name, payment.rental_id, payment.amount, payment.payment_date FROM payment
JOIN customer ON payment.customer_id = customer.customer_id;

SELECT * FROM inventory; # Prueba para identificar llaves primarias

SELECT film.title, staff_id, customer_id, rental_date, inventory.last_update FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;

# ----- PUNTO NO. 4 --------
SELECT * FROM film_category;

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (1, 'Cliente', 'DePrueba', 'cliente.prueba@example.com', 1, 1, NOW());

SELECT customer.first_name, customer.last_name FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL;

SELECT film.title, film.length FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.film_id IS NULL;

# ----- PUNTO NO. 5 --------
#9
INSERT INTO actor (first_name, last_name)
VALUES ('ACTOR','TEMPORAL');
SET @id_temporal = LAST_INSERT_ID(); # Se maneja de esta manera, utilizando un set para no tener que adivinar el id para futuras consultas

#10
UPDATE actor
SET first_name='ACTOR', last_name ='TEMPORAL'
WHERE actor_id = @id_temporal;

SELECT * FROM actor
WHERE first_name = 'ACTOR';

#11
DELETE FROM actor
WHERE actor_id = @id_temporal;

# ----- PUNTO NO. 6 --------

SELECT first_name, last_name, SUM(amount) FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id 
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT film.title, COUNT(*)  FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY COUNT(*) DESC
LIMIT 5;


