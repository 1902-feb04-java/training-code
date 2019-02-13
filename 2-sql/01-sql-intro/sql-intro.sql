-- comments in SQL with --

-- SELECT statement runs queries against the database:
-- no modification, only reading.

SELECT * FROM films;

SELECT title FROM films;

-- column aliasing
select title AS "Title", release_year AS "Year Released" from films;

-- all films with rental duration more than 3 days
SELECT *
FROM films
WHERE rental_duration > 3;

-- all films with title that sort before "B"
-- (all films starting with letter A.)
SELECT *
FROM films
WHERE title < 'B';

-- we can combine conditions with boolean operators AND and OR.
-- all films starting with A with 3 day rental.
SELECT *
FROM films
WHERE title < 'B' AND rental_duration = 3;