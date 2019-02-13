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
-- brackets do the same thing as double quotes.

-- Ctrl+/ will comment just like in VS Code
-- Ctrl+Space triggers autocomplete of column names
--   (if the FROM clause is already written)

-- exercises:

-- 1. list all customers (full names, customer ID, and country)
--    who are not in the US.

-- 2. list all customers from brazil.

-- 3. list all sales agents.

-- 4. show a list of all countries in billing addresses on invoices.
--    (there should not be duplicates in the list, figure out how to do that)

-- 5. how many invoices were there in 2009, and what was the
--    sales total for that year? what about 2011 (can use a separate query)?

-- 6. how many line items were there for invoice #37?

-- 7. how many invoices per country?

-- 8. show total sales per country,
--    ordered by highest sales first (figure out how to do that)
