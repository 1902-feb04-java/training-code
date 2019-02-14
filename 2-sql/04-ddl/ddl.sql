 -- DDL
 -- Data Definition Language
 
 -- operates on tables (and other objects), is not aware of individual rows.
CREATE DATABASE mydatabase;
DROP DATABASE mydatabase;

CREATE SCHEMA myschema;
DROP SCHEMA myschema;
 -- schemas are like namespaces/scopes for tables and other objects.

CREATE SCHEMA rest_reviews;

-- normally, we'd have to qualify our tables with the schema name
-- but we can change search_path from its default of public
-- to look in our schema we're working in right now.
SET search_path TO rest_reviews,public;

DROP TABLE rest_reviews.reviews;
CREATE TABLE rest_reviews.reviews (
	id SERIAL NOT NULL,
	reviewer CHARACTER VARYING(100) NOT NULL,  -- abbrev VARCHAR
	score NUMERIC(4, 2) NOT NULL, -- 4 digits total, 2 after the decimal point
	restaurant_id INTEGER NOT NULL,
	text TEXT NULL,
	last_updated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	-- it's good to give our more complicated constraints names explicitly
	-- instead of relying on the generated names, so that code that
	-- accesses them later makes sense
	CONSTRAINT pk_reviews_id PRIMARY KEY (id),
		-- name of constraint, type of constraint, list of columns in the PK
	CONSTRAINT chk_reviews_score_min_0 CHECK (score >= 0),
	CONSTRAINT u_reviews_reviewer_restaurant UNIQUE (restaurant_id, reviewer)
);

-- PostgreSQL supports something called "sequences"
-- we could set up a default value for our IDs based on a sequence object
--   to provide "auto-incrementing" behavior.
-- but, there is a built-in shortcut for that called "SERIAL" type.

DROP TABLE rest_reviews.restaurants;
CREATE TABLE rest_reviews.restaurants (
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	cuisine VARCHAR(100) NULL,
	address_line1 VARCHAR(100) NOT NULL,
	address_line2 VARCHAR(100) NULL,
	city VARCHAR(100) NOT NULL,
	state VARCHAR(100) NOT NULL,
	country VARCHAR(100) NOT NULL,
	zipcode VARCHAR(10) NULL,
	opening_time TIME WITHOUT TIME ZONE NULL DEFAULT ('9:00 AM'),
	closing_time TIME WITHOUT TIME ZONE NULL DEFAULT ('11:00 PM'),
	CONSTRAINT pk_restaurants_id PRIMARY KEY (id)
);

-- alter table can add columns or constraints
ALTER TABLE reviews
	ADD CONSTRAINT fk_reviews_restaurants_Nto1
		FOREIGN KEY (restaurant_id) REFERENCES restaurants (id);
-- if you add column to table that already has rows, it must have either
--   a default, or allow null (or else what would go in the new cells?)

-- all FORIEGN KEY constraint does is throw errors if you try to violate
--   referential integrity.

-- indexes
-- indexes exist on tables in SQL, with big influence on read and write performance.
-- lookup by the values of indexed columns are the fastest.
--     because, they are like an actual index in
--     a book.

-- tradeoff of indices is overhead on writes, for the sake of faster reads.
-- by default, the primary key and every unique constraint have associated indexes.

-- multiplicity
-- fancy word for a characteristic of a relationship between
--    two entities in your data model
-- whether the relationship is
--      one-to-one (1..1),
--      one-to-many (1..N), or
---     many-to-many (N..N).
-- for 1-to-1, we will either include the second entity entirely in
--    the columns of the first entity's table, or, have two tables, with a foreign key on
--    one of them, with a unique constraint also
--    (e.g. restaurants and addresses)
--    (technically, because foreign key can only go one way, this is "1-to-(0 or 1)")
-- for 1-to-N, we will have two tables, and put a foreign key from the
--    "N" side, to the "1" side. (possibly with a NOT NULL as well)
-- for N-to-N, we will have THREE tables, one of them for the relationship itself,
--    called a "join table" or a "junction table", having two foreign keys, one
--    for each of the other tables.

-- constraints:
--   NOT NULL (NULL not allowed as a value)
--         (allowing NULL is the default, but it's good to be explicit and
--          put "NULL" to annotate that we are allowing it)
--   NULL (doesn't constrain anything, not really a constraint)
--   PRIMARY KEY (enforces uniqueness, not-null-ness, and sets an index)
--   CHECK (enforces an arbitrary condition on the values in any row)
--   DEFAULT
--   UNIQUE (sets an index)
--   FOREIGN KEY

