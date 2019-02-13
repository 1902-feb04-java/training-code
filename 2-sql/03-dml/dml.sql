-- DML
-- Data Manipulation Language
-- has five statements in PostgreSQL:
--   SELECT, INSERT, UPDATE, DELETE, TRUNCATE TABLE.

-- the purposes of DML is to interact on a row-by-row basis.
-- for wholesale modification of tables, we use other statements (DDL)

-- INSERT will add a row to a table.

SELECT * FROM genres;
-- insert some new genres into the genre table
INSERT INTO genres (name) VALUES ('Misc 1');
INSERT INTO genres (id, name) VALUES (27, 'Misc 2');
-- id column in this case has a default configured, so
-- we can leave it blank.
-- otherwise, un-provided values are set to NULL.
-- if the column doesn't allow NULL and has no default,
--   you do have to provide a value.
INSERT INTO genres (name) VALUES
	('Misc 3'),
	('Misc 4');
-- we can insert multiple rows at once like that
-- INSERT has more complicated versions that can pull data from CSV files,
-- things like that

-- DELETE deletes rows
-- this would remove every row, leaving an empty table.
-- DELETE FROM genres;

DELETE FROM genres
WHERE genres.id = 27;
-- we use a WHERE clause to limit what will be removed.
-- can do all the stuff in WHERE that we could in SELECT's WHERE.


-- UPDATE

-- update every genre named "Misc 1" to become named "Miscellaneous 1"
UPDATE genres SET
	name = 'Miscellaneous 1',
	-- more column-name = value pairs, if we had any
WHERE name = 'Misc 1';

SELECT * FROM genres;

-- exercises:

-- 1. insert two new records into the employee table.

-- 2. insert two new records into the tracks table.

-- 3. update customer Aaron Mitchell's name to Robert Walter

-- 4. delete one of the customers you inserted.

-- 5. delete customer Robert Walter. you'll also need to remove all
--    other rows in other tables that ultimately depend on his existence
--    via foreign key relationships to get past the error.
