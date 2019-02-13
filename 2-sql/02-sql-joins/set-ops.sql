-- set operations

-- in SQL we have some ways to combine two separate result sets.
-- operators UNION, UNION ALL,
--           INTERSECT, INTERSECT ALL,
--           EXCEPT, EXCEPT ALL

-- UNION involves concatenating two result sets into one.
--   (the number of columns and their types have to be the same)

-- all first names of customers and employees
SELECT employees.first_name FROM employees
UNION
SELECT customers.first_name FROM customers;

-- for every set operator, there is an "ALL" version of it.
-- the default version (technically the "DISTINCT" version) removes all duplicates.
SELECT employees.first_name FROM employees
UNION ALL
SELECT customers.first_name FROM customers;
-- this one has some duplicate results.

-- the ALL versions are faster, because they don't need to spend time
-- removing duplicates.


-- all first names that are had by both a customer and an employee
SELECT employees.first_name FROM employees
INTERSECT
SELECT customers.first_name FROM customers;

-- all employee first names that no customer has
SELECT employees.first_name FROM employees
EXCEPT -- aka "set difference" (subtraction)
SELECT customers.first_name FROM customers;

-- subquery
-- this is another way to combine the data from multiple tables
-- any query you would write with joins, can usually be rewritten with subqueries
-- instead, and vice versa.

-- every track that has never been purchased
SELECT t.name
FROM tracks AS t
WHERE t.id NOT IN ( -- subquery
		SELECT il.track_id
		FROM invoice_lines AS il
	);

WITH purchased_tracks AS (
		SELECT il.track_id AS id
		FROM invoice_lines AS il
	)
SELECT t.name
FROM tracks AS t
WHERE t.id NOT IN (SELECT id FROM purchased_tracks);
-- the WITH clause lets us "declare" our subqueries before the main query
-- instead of in the middle of it.

-- for subqueries, we have operators:
--   EXISTS, NOT EXISTS
--   IN, NOT IN
--   SOME (aka ANY)
--   ALL

