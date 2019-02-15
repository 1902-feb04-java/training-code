-- functions
-- we can make re-usable functions in a variety of SQL-extension languages
-- we'll look at "SQL" functions and "PL/pgSQL" functions

-- a function that returns the current time.
CREATE FUNCTION get_current_time() RETURNS TIME WITH TIME ZONE
AS
$$
	SELECT CURRENT_TIME;
$$ LANGUAGE SQL;
-- the function implicitly returns the last statement inside it.
-- we have VOID return type for when we don't need to return anything.

SELECT get_current_time();

-- we can give functions parameters and have them interact with tables
CREATE FUNCTION get_customer_initials(customer_id INTEGER) RETURNS VARCHAR(2)
AS
$$
	SELECT SUBSTRING(first_name, 1, 1) || SUBSTRING(last_name, 1, 1)
	FROM customers
	WHERE id = customer_id;
$$ LANGUAGE SQL;

SELECT get_customer_initials((
	SELECT id FROM customers
	WHERE first_name = 'Eduardo'
	LIMIT 1
));

SELECT * FROM employees;
CREATE FUNCTION all_employees_before_1970() RETURNS SETOF employees AS
$$
	SELECT * FROM employees
	WHERE EXTRACT(YEAR FROM birth_date) < 1970
$$ LANGUAGE SQL;
SELECT all_employees_before_1970(); -- stuffs whole employee into one column
SELECT * FROM all_employees_before_1970(); -- expands employee back into his columns

CREATE FUNCTION employee_names() RETURNS TABLE(
	first_name VARCHAR(20),
	last_name VARCHAR(20)
) AS
$$
 	SELECT first_name, last_name
 	FROM employees;
$$ LANGUAGE SQL;
SELECT * FROM employee_names();

-- the $$ $$ syntax is actually a multi-line string literal
CREATE OR REPLACE FUNCTION name_of_alpha_last_employee(
	OUT first VARCHAR(20), OUT last VARCHAR(20)
) AS
$$
	SELECT first_name, last_name
	FROM employees 
	ORDER BY last_name DESC, first_name DESC 
	LIMIT 1;
$$ LANGUAGE SQL;
SELECT * FROM name_of_alpha_last_employee();

-- the parameters are also accessible with names $1, $2, $3 etc
-- so you don't need to give them names if you want to use those instead

-- exercises

-- 1. create a function that returns the length of a track

-- 2. create a function that returns the average total of all
--    invoices

-- 3. create a function that returns the most expensive track

-- 4. create a function that returns the average price of all invoice line
--    items

-- 5. create a function that updates some of the personal info of an
--    employee.

-- 6. create a function that, given an employee, returns all the employees he
--    manages (that report to him).

-- 7. create a function that, given an invoice id, will delete that
--    invoice, including all associated invoice line items.

-- PL/pgSQL functions support more procedural constructs like
-- if-conditional, loop, try catch

-- this function will be called whenever we want to suppress some row change
CREATE OR REPLACE FUNCTION skip_row_operation_trigger() RETURNS trigger AS
$$
	BEGIN
		-- RAISE lets us "throw exceptions"
		RAISE 'deleting expensive invoice not allowed';
	END;
$$ LANGUAGE plpgsql;
-- in a trigger function for BEFORE triggers, returning NULL
-- halts the operation before it occurs.

-- triggers
-- we have them on INSERT, on UPDATE, or on DELETE
-- also, BEFORE, AFTER, or INSTEAD OF (but INSTEAD OF only on views, not proper tables)
-- also, row-level trigger (FOR EACH ROW) or statement-level (FOR EACH STATEMENT)
DROP TRIGGER prevent_expensive_invoice_delete ON invoices;
CREATE TRIGGER prevent_expensive_invoice_delete
BEFORE DELETE
ON invoices
FOR EACH ROW
WHEN (OLD.total > 20) -- total for invoice is > $20
EXECUTE PROCEDURE skip_row_operation_trigger();

-- inside a row-level trigger (including the function), we have access to 
-- special variables OLD (for delete and update)
-- and NEW (for insert and update)

SELECT * FROM invoices ORDER BY total DESC;
DELETE FROM invoice_lines WHERE invoice_id = 404;
DELETE FROM invoices WHERE id = 404; -- prevented by trigger

CREATE OR REPLACE FUNCTION update_last_updated() RETURNS trigger
AS $$
BEGIN
	UPDATE rest_reviews.reviews
	SET last_updated = 'now'
	WHERE id = NEW.id;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER reviews_last_updated_insert ON rest_reviews.reviews;
CREATE TRIGGER reviews_last_updated_insert
AFTER INSERT
ON rest_reviews.reviews
FOR EACH ROW
WHEN (pg_trigger_depth() = 0) -- prevent trigger recursion
EXECUTE PROCEDURE update_last_updated();

DROP TRIGGER reviews_last_updated_update ON rest_reviews.reviews;
CREATE TRIGGER reviews_last_updated_update
AFTER UPDATE
ON rest_reviews.reviews
FOR EACH ROW
WHEN (pg_trigger_depth() = 0) -- prevent trigger recursion
EXECUTE PROCEDURE update_last_updated();

SELECT * FROM rest_reviews.reviews;
INSERT INTO rest_reviews.reviews (reviewer, score, restaurant_id) VALUES
('Nick', 7.5,
 (SELECT id FROM rest_reviews.restaurants WHERE name = 'McDonalds' LIMIT 1)
);
UPDATE rest_reviews.reviews
SET score = 8.0
WHERE reviewer = 'Nick';

-- procedures only exist in PostgreSQL 11, they have no return,
-- and they do allow transactions with BEGIN+COMMIT(+SAVEPOINT+ROLLBACK)
-- unlike functions. otherwise
DROP FUNCTION test_proc();
CREATE OR REPLACE FUNCTION test_proc() RETURNS INTEGER
AS $$
-- optional DECLARE, plus BEGIN, plus END is a "block"
-- blocks can be nested
DECLARE
	-- declare our variables
	-- PostgreSQL does have variables, in the context of functions/procedures
	value INTEGER;
	value2 VARCHAR(20);
	-- just like function parameters, we can have table-valued variables
	-- row-valued variables etc.
BEGIN
	-- our statements
	-- assignment :=
	value := 600;
	IF value < 10
	THEN
		value := 12;
	ELSIF value > 100
	THEN
		value := 200;
	END IF;
	-- we have if, else if, else in pl/pgsql
	-- we also have while loops
	WHILE value > 100 LOOP
		value = value - 60;
	END LOOP;
	RETURN value;
END;
$$ LANGUAGE plpgsql;

SELECT test_proc();

CREATE OR REPLACE FUNCTION test_func() RETURNS VOID AS
$$
	BEGIN
		CALL test_proc();
	END;
$$ LANGUAGE plpgsql;
