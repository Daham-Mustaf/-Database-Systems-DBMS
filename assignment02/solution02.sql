-- 1- Measurements

DROP TABLE IF EXISTS measurements;
-- Create the measurements table
CREATE TABLE measurements (
    id serial PRIMARY KEY,
    t numeric,
    m numeric[]
);

-- Insert the measurements from the note
INSERT INTO measurements (t, m)
VALUES
    (1.0, ARRAY[1.0, 3.0, 5.0, 5.0]),
    (2.5, ARRAY[0.8, 2.0]),
    (4.0, ARRAY[0.5]),
    (5.5, ARRAY[3.0]),
    (8.0, ARRAY[2.0, 6.0, 8.0]),
    (10.5, ARRAY[1.0, 3.0, 8.0]);




-- (b) Compute a one-column table with the global maximum of the measurements 𝑚(𝑡).
SELECT MAX(value) AS global_max
FROM (
    SELECT unnest(m) AS value
    FROM measurements
) AS flattened;

-- (c) Compute a two-column table that lists each time 𝑡 and the average of its measurements 𝑚(𝑡).
SELECT t, AVG(value) AS average_m
FROM (
    SELECT t, unnest(m) AS value
    FROM measurements
) AS flattened
GROUP BY t
ORDER BY t;

-- (d) Compute a two-column table that lists the average of all measurements 𝑚(𝑡) in each timeframe
-- [0.0 − 5.0), [5.0 − 10.0), [10.0 − 15.0), …

WITH timeframes AS (
    SELECT generate_series(0, 15, 5) AS start_time, generate_series(5, 20, 5) AS end_time
)
SELECT
    tframe.start_time AS start_time,
    tframe.end_time AS end_time,
    AVG(value) AS average_m
FROM
    timeframes AS tframe
LEFT JOIN (
    SELECT
        t,
        unnest(m) AS value
    FROM
        measurements
) AS flattened
ON
    flattened.t >= tframe.start_time AND flattened.t < tframe.end_time
GROUP BY
    tframe.start_time, tframe.end_time
ORDER BY
    tframe.start_time;


-- Find all times 𝑡 (there may be more than one) at which the global maximum was recorded. The
-- result is a two-column table that lists time 𝑡 and the global maximum.
WITH max_values AS (
    SELECT t, MAX(value) AS global_max
    FROM (
        SELECT t, unnest(m) AS value
        FROM measurements
    ) AS flattened
    GROUP BY t
)
SELECT t, global_max
FROM max_values
WHERE global_max = (SELECT MAX(global_max) FROM max_values);



-- sample of quereis in the lecture
-- Advanced SQL — Chapter 02 — Video #04 — SELECT/FROM/WHERE
VALUES (1),
       (2);    

VALUES(1,2)

-- three rows 2 columns 
VALUES(false,2),
      (true, 1),
      (Null, Null);


SELECT t.*
FROM (VALUES(false,0),
            (true, 1)) AS t(truth, "binary");



-- Chapter 02 — Video #05

SELECT 2 + (SELECT t.d
            FROM T AS t
            WHERE t.a = 2) AS "The Answer";



-- Create the table
CREATE TABLE T (
    a INT,
    b CHAR(1),
    c BOOLEAN,
    d INT
);

-- Insert data into the table
INSERT INTO T (a, b, c, d)
VALUES
    (1, 'X', TRUE, 10),
    (2, 'Y', TRUE, 40),
    (3, 'X', FALSE, 30),
    (4, 'y', FALSE, 20),
    (5, 'X', TRUE, NULL); -- Assuming the last row has a NULL value for column d 