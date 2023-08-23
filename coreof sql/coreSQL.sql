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


