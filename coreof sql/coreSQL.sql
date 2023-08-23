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
INSERT INTO T (a, b, c, d)
VALUES
    (1, 'X', TRUE, 10),
    (2, 'Y', TRUE, 40),
    (3, 'X', FALSE, 30),
    (4, 'y', FALSE, 20),
    (5, 'X', TRUE, NULL); -- Assuming the last row has a NULL value for column d 
    

    