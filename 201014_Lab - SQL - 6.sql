--  Lab | SQL Queries 6
-- We are going to do some database maintenance. We have received the film catalog for 2020. 
-- The catalog is in a CSV file named **films_2020.csv** that can be found at `files_for_lab` folder.

USE sakila;
-- show variables like 'local_infile';
-- set global local_infile = 1;

		-- Add the new films to the database. 
			-- We make a table film_2020 to import the csv file.
create table film_2020
(title varchar(250),
description varchar(3000),
release_year int,
language_id int,
original_language_id tinyint unsigned,
rental_duration int,
rental_rate decimal(4,2),
length int,
replacement_cost float,
rating varchar(10),
special_features varchar(3000));         -- right click film_2020 table - table data import wizard

SELECT * FROM sakila.film_2020;
SELECT * FROM sakila.film;
describe sakila.film;
SELECT * FROM sakila.inventory;

												-- Adding films from film_2020 to film.
INSERT INTO sakila.film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, rating, special_features)
SELECT title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, rating, special_features FROM sakila.film_2020;

SELECT * FROM sakila.film
where release_year in (2020); -- Checking additions to film

-- Update inventory.
-- We have just one item for each film, and all will be placed in store 2. 
show fields from inventory;
show fields from rental;
select*from sakila.inventory;

Insert into inventory(film_id, store_id)
select film_id, 2
from film
where release_year = 2020;


-- All other movies will be moved to store 1. 
Insert into inventory(film_id, store_id)
select film_id, 1
from film
where release_year <> 2020;

-- The rental duration will be 3 days, with an offer price of 2.99€ and a replacement cost of 8.99€. 
update film set rental_duration = 3, rental_rate=2.99, replacement_cost=8.99 where release_year = 2020;



