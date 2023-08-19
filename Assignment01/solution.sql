-- Create a table r with schema r(a int, b int)
CREATE TABLE r (
    a INTEGER,
    b INTEGER
);
-- Insert data into the table r
INSERT INTO r (a, b) VALUES
    (1, 2),
    (1, 4),
    (2, 3),
    (2, 1),
    (3, 5);

SELECT r.a, COUNT(*) AS c
FROM r AS r
WHERE r.b > 3
GROUP BY r.a;

-- q2\
CREATE TABLE production (
    step int NOT NULL,
    item char(20) NOT NULL,
    completion timestamp,
    PRIMARY KEY (item, step)
);
-- Insert data into the production table
INSERT INTO production (step, item, completion)
VALUES
    (1, 'TIE', '1977/03/02 04:12'),
    (2, 'TIE', '1977/12/29 05:55'),
    (1, 'DSII', '1978/01/03 14:12'),
    (2, 'AT-AT', NULL),
    (1, 'AT-AT', NULL),
    (2, 'DSII', '1979/05/26 20:05'),
    (3, 'DSII', '1979/04/04 17:12');


-- Formulate a SQL query that lists the names of all items for which all production steps are complete. Avoid duplicate item names. For the instance above, we expect the following result:
SELECT item
FROM production
GROUP BY item
HAVING COUNT(*) = COUNT(completion);

-- Matrix Multiplication
-- Create table A
CREATE TABLE A (
    row int,
    col int,
    val int,
    PRIMARY KEY (row, col)
);

-- Create table B with the same structure as A
-- Drop the existing table B if you intend to replace it
DROP TABLE IF EXISTS B;
CREATE TABLE B (
    row int,
    col int,
    val int,
    PRIMARY KEY (row, col)
    -- FOREIGN KEY (row, col) REFERENCES A(row, col)
);

INSERT INTO A (row, col, val)
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (2, 1, 3),
    (2, 2, 4);

INSERT INTO B (row, col, val)
VALUES
    (1, 1, 1),
    (1, 2, 2),
    (1, 3, 1),
    (2, 1, 2),
    (2, 2, 1),
    (2, 3, 2);


SELECT
    a.row AS row,
    b.col AS col,
    SUM(a.val * b.val) AS val
FROM
    A AS a
JOIN
    B AS b ON a.col = b.row
GROUP BY
    a.row, b.col
ORDER BY
    a.row, b.col;






