-- Create the prehistoric table
CREATE TABLE IF NOT EXISTS prehistoric (
    class VARCHAR(255),
    herbivore BOOLEAN,
    legs INT,
    species VARCHAR(255)
);

-- Insert sample data into the prehistoric table
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
