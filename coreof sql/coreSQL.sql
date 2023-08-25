-- Advanced SQL
-- 02 — The Core of SQL
-- Summer 2022
-- Torsten Grust
-- Universität Tübingen, Germany

-- Create the table
CREATE TABLE T (
    a INT,
    b CHAR(1),
    c BOOLEAN,
    d INT
);

DELETE FROM T;

INSERT INTO T (a, b, c, d)
VALUES
    (1, 'X', TRUE, 10),
    (2, 'Y', TRUE, 40),
    (3, 'X', FALSE, 30),
    (4, 'Y', FALSE, 20),
    (5, 'X', TRUE, NULL); -- Assuming the last row has a NULL value for column d 



SELECT t1.*
FROM (SELECT t2.* 
FROM T AS t2 ORDER BY t2.b) AS t1;
    
SELECT t.b, t.d  -- "t.d" must appear in the GROUP BY clause or be used in an aggregate function
FROM T AS t
GROUP BY t.b


-- Select the 'b' column from the table 'T' and calculate the sum of 'd' for each group.
SELECT t.b, SUM(t.d) AS "∑d"

-- Specify the table 'T' and provide it with the alias 't' for convenience.
FROM T AS t

-- Group the rows by the 'b' column, so that the following aggregation functions are applied within each group.
GROUP BY t.b;


-- Aggregates are Evaluated Once Per Group
SELECT
    t.b AS "group", -- Select the 'b' column as 'group'
    COUNT(*) AS size, -- Calculate the count of rows in each group
    SUM(t.d) AS "∑d", -- Calculate the sum of 'd' in each group
    EVERY(t.a % 2 = 0) AS "∀even(a)", -- Check if every 'a' is even in each group
    -- Concatenate the values in the 'a' column as a single string, separated by semicolons,
    -- and alias the result column as "all a".
    string_agg(t.a :: text, '; ') AS "all a"

FROM
    T AS t -- Specify the table 'T' with alias 't'
GROUP BY
    t.b; -- Group the results by the 'b' column

-- Calculate whether the value in column 'a' is odd by taking the modulo 2.
-- Alias the result column as "an odd?" to indicate whether the value is odd or not.
SELECT t.a % 2 AS "an odd?",
    
-- Count the number of rows in each group (odd or even) using GROUP BY.
-- Alias the result column as "size" to represent the size of each group.
        COUNT(*) AS size

-- Specify the table name as 'T' and alias it as 't'.
FROM T as t

-- Group the results by the calculated value of 't.a % 2'.
GROUP BY t.a % 2;


-- 12 ┆ Bag and Set Operations


CREATE TABLE prehistoric (
    class VARCHAR(255),
    herbivore BOOLEAN,
    legs INT,
    species VARCHAR(255)
);

INSERT INTO prehistoric (class, herbivore, legs, species)
VALUES
    ('mammalia', true, 2, 'Megatherium'),
    ('mammalia', true, 4, 'Paraceratherium'),
    ('mammalia', false, 2, NULL),
    ('mammalia', false, 4, 'Sabretooth'),
    ('reptilia', true, 2, 'Iguanodon'),
    ('reptilia', true, 4, 'Brachiosaurus'),
    ('reptilia', false, 2, 'Velociraptor'),
    ('reptilia', false, 4, NULL);

DELETE FROM prehistoric;


SELECT p.class,
       p.herbivore,
       p.legs,
       string_agg(p.species, '; ') AS species
FROM prehistoric as p
GROUP BY GROUPING SETS ((p.class));


SELECT p.class,
       p.herbivore,
       p.legs,
       string_agg(p.species, '; ') AS species
FROM prehistoric as p
GROUP BY ROLLUP (p.class, p.herbivore, p.legs);



-- CUBE
EXPLAIN VERBOSE
SELECT p.class,
       p."herbivore",
       p.legs,
       string_agg(p.species, ', ') AS species  -- string_agg ignores NULL (may use coalesce(p.species, '?'))
FROM   prehistoric AS p
GROUP BY CUBE (class, "herbivore", legs)



DROP TABLE IF EXISTS dinosaurs;
CREATE TABLE dinosaurs (species text, height float, length float, legs int);

INSERT INTO dinosaurs(species, height, length, legs) VALUES
  ('Ceratosaurus',      4.0,   6.1,  2),
  ('Deinonychus',       1.5,   2.7,  2),
  ('Microvenator',      0.8,   1.2,  2),
  ('Plateosaurus',      2.1,   7.9,  2),
  ('Spinosaurus',       2.4,  12.2,  2),
  ('Tyrannosaurus',     7.0,  15.2,  2),
  ('Velociraptor',      0.6,   1.8,  2),
  ('Apatosaurus',       2.2,  22.9,  4),
  ('Brachiosaurus',     7.6,  30.5,  4),
  ('Diplodocus',        3.6,  27.1,  4),
  ('Supersaurus',      10.0,  30.5,  4),
  ('Albertosaurus',     4.6,   9.1,  NULL),  -- Bi-/quadropedality is
  ('Argentinosaurus',  10.7,  36.6,  NULL),  -- unknown for these species.
  ('Compsognathus',     0.6,   0.9,  NULL),  --
  ('Gallimimus',        2.4,   5.5,  NULL),  -- Try to infer pedality from
  ('Mamenchisaurus',    5.3,  21.0,  NULL),  -- their ratio of body height
  ('Oviraptor',         0.9,   1.5,  NULL),  -- to length.
  ('Ultrasaurus',       8.1,  30.5,  NULL);  --

TABLE dinosaurs;


-- Create a Common Table Expression (CTE) named 'bodies' to calculate the average shape ratio for dinosaurs with specified leg counts.
-- The shape ratio is the average height divided by the average length for each leg count.

-- Define the CTE 'bodies' that calculates the average shape ratio.
WITH bodies(legs, shape) AS (
  SELECT d.legs, AVG(d.height / d.length) AS shape
  
  -- Select data from the 'dinosaurs' table.
  FROM dinosaurs AS d
  
  -- Filter out rows where the 'legs' column is not NULL.
  WHERE d.legs IS NOT NULL
  
  -- Group the results by the number of legs.
  GROUP BY d.legs
)
TABLE bodies;


-- -- Create a temporary table to store completed dinosaurs
-- CREATE TEMPORARY TABLE completed_dinosaurs AS
-- SELECT
--     d.id, -- Assuming 'id' is a unique identifier for each dinosaur
--     CASE
--         WHEN d.locomotion IS NOT NULL THEN d.locomotion
--         ELSE
--             -- Compute body shape for μ (replace this with your actual formula)
--             -- For example: body shape is the average of height / length
--             AVG(d.height / d.length)
--     END AS computed_shape
-- FROM dinosaurs AS d;

-- -- Update dinosaurs with unknown locomotion based on closest shape in 'bodies'
-- UPDATE dinosaurs AS d
-- SET locomotion = (
--     SELECT b.legs
--     FROM bodies AS b
--     ORDER BY ABS(b.shape - cd.computed_shape)
--     LIMIT 1
-- )
-- WHERE d.locomotion IS NULL
-- AND EXISTS (
--     SELECT 1
--     FROM completed_dinosaurs AS cd
--     WHERE cd.id = d.id
-- );

-- -- Output the completed dinosaurs
-- SELECT * FROM dinosaurs;
SELECT d.*
FROM   dinosaurs AS d
WHERE  d.legs IS NOT NULL

UNION ALL 

SELECT d.*
FROM  dinosaurs AS d
WHERE d.legs IS NULL;

-- ➋ Realize query plan (assumes table bodies exists)
SELECT d.species, d.height, d.length,
       (SELECT b.legs                               -- Find the shape entry in bodies
        FROM   bodies AS b                          -- that matches d's ratio of
        ORDER BY abs(b.shape - d.height / d.length) -- height to length the closest
        LIMIT 1) AS legs ;