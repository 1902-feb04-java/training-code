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

-- CREATE FUNCTION employee_names() RETURNS
-- 	TABLE(first_name VARCHAR(20), last_name VARCHAR(20)) AS
-- $$
-- 	SELECT first_name, last_name
-- 	FROM employees;
-- $$ LANGUAGE SQL;
-- SELECT * FROM employee_names();
													
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