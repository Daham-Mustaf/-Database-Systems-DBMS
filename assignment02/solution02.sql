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
