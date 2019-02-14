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


-- triggers
-- we can specify automatic behavior to run before, after, or in place of
-- any insert, update or delete.

-- CREATE TRIGGER reviews_last_updated
-- AFTER UPDATE ON reviews AS
	-- inside the trigger, we have access to two special temporary tables -
	-- Inserted