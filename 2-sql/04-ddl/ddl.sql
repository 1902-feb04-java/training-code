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
	id INTEGER NOT NULL,
	reviewer CHARACTER VARYING(100) NOT NULL,  -- abbrev VARCHAR
	score NUMERIC(4, 2) NOT NULL, -- 4 digits total, 2 after the decimal point
	restaurant_id INTEGER NOT NULL,
	text TEXT NULL,
	last_updated TIMESTAMP NOT NULL DEFAULT (localtimestamp),
	-- it's good to give our more complicated constraints names explicitly
	-- instead of relying on the generated names, so that code that
	-- accesses them later makes sense
	CONSTRAINT pk_reviews_id PRIMARY KEY (id),
		-- name of constraint, type of constraint, list of columns in the PK
	CONSTRAINT chk_reviews_score_min_0 CHECK (score >= 0),
	CONSTRAINT u_reviews_reviewer_restaurant UNIQUE (restaurant_id, reviewer)
);



-- constraints:
--   NOT NULL (NULL not allowed as a value)
--         (allowing NULL is the default, but it's good to be explicit and
--          put "NULL" to annotate that we are allowing it)
--   NULL (doesn't constrain anything, not really a constraint)
--   PRIMARY KEY (enforces uniqueness, not-null-ness, and sets the clustered index)
--   CHECK (enforces an arbitrary condition on the values in any row)
--   DEFAULT
--   UNIQUE
--   FOREIGN KEY


--ALTER TABLE