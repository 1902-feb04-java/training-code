-- SELECT statement
-- for making queries to the database (read access, not modifying)
-- made up of several "clauses", six main ones
SELECT *
FROM genres
WHERE LENGTH(name) < 6;

-- we've seen
-- 1. SELECT clause (chooses which columns will be returned)
-- 2. FROM clause (chooses which table to access)
-- 3. WHERE clause (filters rows based on conditions)

-- we have the ability to "aggregate" rows together
-- using "GROUP BY" clause, together with aggregate functions.
-- we have a handful of built-in aggregate functions:
--   SUM, COUNT, AVG, MIN, MAX
SELECT state, COUNT(*), SUM(id)
FROM customers
GROUP BY state;

-- when we use GROUP BY, we can only select columns
-- that are either *part* of the GROUP BY, or,
-- are aggregated

-- the next clause that SELECT has is HAVING

-- list states by how many customers, if at least 2 customers
SELECT state, COUNT(*)
FROM customers
WHERE state IS NOT NULL -- WHERE filters before the grouping
GROUP BY state
HAVING COUNT(*) >= 2; -- HAVING filters after the grouping

-- last clause is ORDER BY
-- list states by how many customers, if at least 2 customers,
--    sort states alphabetically
SELECT state, COUNT(*)
FROM customers
WHERE state IS NOT NULL
GROUP BY state
HAVING COUNT(*) >= 2
ORDER BY state;

-- the logical order of execution of the clauses of SELECT:
--  1. FROM
--  2. WHERE
--  3. GROUP BY
--  4. HAVING
--  5. ORDER BY
--  6. SELECT     (sort of)

-- single quotes are for string literals.
-- double quotes are for identifiers (table names, column names, etc)
--   if they have spaces in them.

-- Ctrl+/ will comment just like in VS Code
-- Ctrl+Space triggers autocomplete of column names
--   (if the FROM clause is already written)

-- exercises:

-- 1. list all customers (full names, customer ID, and country)
--    who are not in the US.
SELECT id, first_name, last_name, country
FROM customers
WHERE country != 'USA';
-- traditional SQL not-equals is <>, but these days we also have !=

-- 2. list all customers from brazil.
SELECT id, first_name, last_name, country
FROM customers
WHERE country != 'Brazil';

-- 3. list all sales agents.
SELECT *
FROM employees
WHERE title = 'Sales Support Agent';

-- 4. show a list of all countries in billing addresses on invoices.
--    (there should not be duplicates in the list, figure out how to do that)
SELECT DISTINCT billing_country
FROM invoices;
-- (also works:)
SELECT billing_country
FROM invoices
GROUP BY billing_country;

-- 5. how many invoices were there in 2009, and what was the
--    sales total for that year? what about 2011 (can use a separate query)?
SELECT
	EXTRACT(YEAR FROM invoice_date) AS "Year",
	SUM(total) AS "Sales Total",
	COUNT(*) AS "Sales Count"
FROM invoices
GROUP BY EXTRACT(YEAR FROM invoice_date)
ORDER BY EXTRACT(YEAR FROM invoice_date);

-- (or, easier way, one query per year:)
SELECT SUM(total)
FROM invoices
WHERE EXTRACT(YEAR FROM invoice_date) = 2009;
-- (another way to work with the date)
SELECT SUM(total)
FROM invoices
WHERE invoice_date >= '2009-01-01' AND invoice_date < '2010-01-01';
--   we have a CAST function to convert between types, and often
--   we rely on implicit conversions like there, from string to timestamp.
-- we also have BETWEEN operator
SELECT SUM(total)
FROM invoices
WHERE invoice_date BETWEEN '2009-01-01' AND '2010-01-01';

-- 6. how many line items were there for invoice #37?
SELECT COUNT(id)
FROM invoice_lines
WHERE invoice_id = 37;

-- 7. how many invoices per country?
SELECT billing_country, COUNT(*)
FROM invoices
GROUP BY billing_country;

-- 8. show total sales per country,
--    ordered by highest sales first (figure out how to do that)
SELECT billing_country, SUM(total) AS Sum
FROM invoices
GROUP BY billing_country
ORDER BY Sum DESC;
