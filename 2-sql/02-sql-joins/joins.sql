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

-- 1. show all invoices of customers from brazil.

-- 2. show all invoices together
--    with the name of the sales agent of each one.

-- 3. show all playlists ordered by the total number of tracks they have.

-- 4. which sales agent made the most in sales in 2009?

-- 5. how many customers are assigned to each sales agent?

-- 6. which track was purchased the most in 2013?

-- 7. show the top five most purchased tracks of all time.

-- 8. show the top three best-selling artists.
