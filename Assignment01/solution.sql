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
