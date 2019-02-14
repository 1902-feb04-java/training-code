SELECT * FROM genres;
-- INNER JOIN

-- all rock songs
SELECT tracks.id, tracks.name
FROM tracks INNER JOIN genres
	ON tracks.genre_id = genres.id
WHERE genres.name = 'Rock';

-- all rock songs (include song name and artist name)
--   || operator concatenates strings
SELECT (artists.name || ' - ' || tracks.name) AS Song
FROM tracks
	INNER JOIN genres ON tracks.genre_id = genres.id
	INNER JOIN albums ON tracks.album_id = albums.id
	INNER JOIN artists ON albums.artist_id = artists.id
WHERE genres.name = 'Rock';
-- we're following foreign key relationships across tables
-- to re-connect the data

-- all customers names paired with their support representative's name (if any)
SELECT
	c.first_name || ' ' || c.last_name AS "Customer",
	e.first_name || ' ' || e.last_name AS "Support Rep."
FROM customers AS c
	LEFT JOIN employees AS e ON c.support_rep_id = e.id;

-- every employee together with their manager (reports_to)
SELECT
	emp.first_name || ' ' || emp.last_name AS "Employee",
	man.first_name || ' ' || man.last_name AS "Manager"
FROM employees AS emp
	LEFT JOIN employees AS man ON emp.reports_to = man.id;
-- this is called a "self join" but that's just a name for
-- any kind of join of a table with itself.

-- back to "all rock songs" ...
-- we have "comma join" syntax (FROM tracks, genres)
-- sometimes people put the join condition in the WHERE instead of the FROM .. ON.
--    (WHERE tracks.genre_id = genre.id)
SELECT tracks.id, tracks.name
FROM tracks JOIN genres ON tracks.genre_id = genre.id
WHERE genres.name = 'Rock';

-- with no condition (or always-true condition), all joins reduce to a cross join

-- left and right outer joins include all rows of one of the
-- tables, filling in NULLs whenever there is no matching row

-- exercises

-- 1. show all invoices of customers from brazil (mailing address not billing).
SELECT c.first_name || ' ' || c.last_name AS "Customer", c.address, c.country, i.*
FROM invoices AS i
	JOIN customers AS c ON i.customer_id = c.id
WHERE c.country = 'Brazil';

-- 2. show all invoices together
--    with the name of the sales agent of each one.
SELECT
	invoices.*,
	employees.first_name || ' ' || employees.last_name AS "Sales Agent"
FROM invoices
	JOIN customers ON invoices.customer_id = customers.id
	JOIN employees ON customers.support_rep_id = employees.id;

-- 3. show all playlists ordered by the total number of tracks they have.
SELECT p.name, COUNT(pt.track_id)
FROM playlist_track AS pt
	JOIN playlists AS p ON pt.playlist_id = p.id
GROUP BY p.name
ORDER BY COUNT(pt.track_id) DESC;

-- 4. which sales agent made the most in sales in 2009?
-- TODO: fix this
SELECT id, first_name, last_name
FROM employees JOIN customers ON customers.support_rep_id = employees.id
	JOIN invoices ON invoices.customer_id = customers.id
WHERE EXTRACT(YEAR FROM invoices.invoice_date) = 2009 AND id IN (
SELECT
	COUNT(employees.id),
FROM employees JOIN customers ON customers.support_rep_id = employees.id
	JOIN invoices ON invoices.customer_id = customers.id
WHERE EXTRACT(YEAR FROM invoices.invoice_date) = 2009
GROUP BY employees.id, employees.first_name, employees.last_name
ORDER BY Sales DESC
LIMIT 1;

-- 5. how many customers are assigned to each sales agent?

-- 6. which track was purchased the most since 2010?
--    (if there's a tie, return the first one alphabetically)
SELECT t.name, COUNT(t.id)
FROM invoice_lines AS il
	JOIN invoices AS i ON il.invoice_id = i.id
	JOIN tracks AS t ON il.track_id = t.id
WHERE i.invoice_date > '2010-01-01'
GROUP BY t.id, t.name
ORDER BY COUNT(t.id) DESC, t.name
LIMIT 1;

-- 7. show the top five most purchased tracks of all time.

-- 8. show the top three best-selling artists.

-- 9. which customers have the same initials as at least one other customer?
--    (see https://www.postgresql.org/docs/9.6/functions-string.html)
-- join version
SELECT c1.first_name, c1.last_name
FROM customers AS c1 JOIN customers AS c2 ON
	(SUBSTRING(c1.first_name, 1, 1) = SUBSTRING(c2.first_name, 1, 1) AND
	 SUBSTRING(c1.last_name, 1, 1) = SUBSTRING(c2.last_name, 1, 1));
-- subquery version
SELECT first_name, last_name
FROM customers
WHERE (SUBSTRING(first_name, 1, 1) || SUBSTRING(last_name, 1, 1)) IN (
	SELECT (SUBSTRING(first_name, 1, 1) || SUBSTRING(last_name, 1, 1))
	FROM customers
);
