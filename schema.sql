DROP TABLE IF EXISTS training_sessions;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS trainers;

CREATE TABLE customers (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL
);

INSERT INTO customers (name) VALUES
('John'),
('Maria'),
('Alex'),
('Sophie');

CREATE TABLE trainers (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL
);

INSERT INTO trainers (name) VALUES
('Mike'),
('Sarah'),
('David'),
('Emma');

CREATE TABLE training_sessions (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

customer_id INT NOT NULL
REFERENCES customers(id),

trainer_id INT NOT NULL
REFERENCES trainers(id),

session_date DATE NOT NULL,

duration_minutes INT NOT NULL
);




