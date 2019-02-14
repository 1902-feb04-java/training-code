-- more DDL

SET search_path TO rest_reviews,public;

INSERT INTO restaurants (name, address_line1, city, state, country) VALUES
	('McDonalds', '123 Main St', 'Dallas', 'TX', 'US'),
	('Restaurant', '123 Main St', 'Paris', '', 'France');

-- views
-- views are make-believe tables that actually run queries every time you access them

-- suppose i am constantly running queries against just the American restaurants
CREATE OR REPLACE VIEW rest_reviews.us_restaurants AS
	SELECT *, address_line1 || COALESCE(' ' || address_line2, '') AS address_lines FROM restaurants AS r
	WHERE r.country = 'US';

-- (The COALESCE function returns the first of its arguments that is not null.)

SELECT * FROM restaurants;
SELECT * FROM us_restaurants;

-- we can INSERT, UPDATE, DELETE "simple" columns in views.
-- this provides some abstraction in SQL where we can access the data
-- in many more user-friendly ways without needing to know
-- the exact table structure for real.

-- data types to know
-- https://www.postgresql.org/docs/current/datatype.html
-- number data types:
--    smallint (2-byte)
--    int/integer (4-byte)
--    bigint (8-byte)
--    numeric/decimal(p, s)
--       p = precision = number of digits, s = scale = digits after decimal
--    serial (special integer with auto-increment behavior, use for IDs)
--    money (for storing currency values, based on locale)
-- string/character types:
--    character/char(n) (fixed-length string)
--    character varying/varchar(n) (variable-length string up to max length)
--    text (unlimited length string)
-- binary types:
--    bytea ("byte array")
-- date/time types:
--    timestamp with/without time zone (default without) -- time and date.
--    time with/without time zone (default without) -- just time.
--    date -- just date.
--    interval -- a difference between two timestamps.
-- boolean type for true or false
-- many other fancy specialized types for geometric objects, geographical locations

-- some functions / behaviors in PostgreSQL to know
--SELECT 1;
--SELECT 1 + 1;
--SELECT CURRENT_TIMESTAMP, LOCALTIMESTAMP, CURRENT_TIME, LOCALTIME;
-- we can do explicit type conversions using CAST
--SELECT CAST (123 AS VARCHAR);
--SELECT EXTRACT(YEAR FROM CAST ('today' AS TIMESTAMP));
--SELECT DATE_PART('month', CAST ('2018-06-01' AS TIMESTAMP)); -- another way to get parts
--SELECT CAST ('today' AS TIMESTAMP) - CAST ('yesterday' AS TIMESTAMP);
-- we can extract lots of parts of the dates and times
-- and we can convert (for display) the time zone using AT TIME ZONE

-- we have "scalar" (single-valued) variables... in pl/pgsql
-- and table-valued variables...  in pl/pgsql

-- string functions
					 --   1234567
SELECT POSITION('bc'  in 'abcdefg'); -- returns 2
SELECT POSITION('def' in 'abcdefg'); -- returns 4
SELECT UPPER('abc'); -- return 'ABC'
SELECT LOWER('ABC'); -- return 'abc'
SELECT '|' || TRIM(LEADING FROM '    abc    ') || '|';
SELECT '|' || TRIM(TRAILING FROM '    abc    ') || '|';
SELECT '|' || TRIM(BOTH FROM '    abc    ') || '|';
SELECT LENGTH('abc'), CHAR_LENGTH('abc'); -- two ways to get string length
SELECT REPLACE('Hello world world', 'world', 'Nick'); -- return 'Hello Nick Nick'
-- in SQL, indexing is 1-based, not 0-based.

-- we have a pattern-matching syntax used with LIKE operator
-- % wildcard means "any number of any characters"
SELECT first_name FROM customers
WHERE first_name LIKE 'A%';
-- _ wildcard means "one of any character"
SELECT first_name FROM customers
WHERE first_name LIKE 'A___andre';
-- for anything more complicated, use SIMILAR TO

-- triggers
-- we can specify automatic behavior to run before, after, or in place of
-- any insert, update or delete.

-- CREATE TRIGGER reviews_last_updated
-- AFTER UPDATE ON reviews AS
	-- inside the trigger, we have access to two special temporary tables -
	-- Inserted