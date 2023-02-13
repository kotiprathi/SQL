create database constraint_airlines;
use constraint_airlines;

create table pk_airlines
(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(90)
)
AUTO_INCREMENT = 100;

-- Insert a row, ID will be automatically generated
INSERT INTO pk_airlines (name) VALUES ('United Airlines');
-- Get generated ID
SELECT LAST_INSERT_ID();
-- Returns: 100

INSERT INTO pk_airlines (name) VALUES ('Indian Airlines');
INSERT INTO pk_airlines (name) VALUES ('Air India');
INSERT INTO pk_airlines (name) VALUES ('Deccan Airlines');
INSERT INTO pk_airlines (name) VALUES ('Jazz Airlines');
INSERT INTO pk_airlines (name) VALUES ('SpiceJet');
INSERT INTO pk_airlines (id,name) VALUES (10,'SpiceJet');
INSERT INTO pk_airlines (name) VALUES ('my airlines');
INSERT INTO pk_airlines (id,name) VALUES (200,'Brithish AIrlines');
INSERT INTO pk_airlines (name) VALUES ('Air France');  -- it will increment based on last insert id.
INSERT INTO pk_airlines (id,name) VALUES (250,'KLM');
INSERT INTO pk_airlines (name) VALUES ('Vistara');
INSERT INTO pk_airlines VALUES (0,'Hello Airlines');
INSERT INTO pk_airlines VALUES (null,'Singapore Airlines');

select * from pk_airlines;
SELECT LAST_INSERT_ID();

INSERT IGNORE INTO pk_airlines VALUES
(200, 'North Air'), -- this row will be skipped as ID 200 already exists, and IGNORE option used
(0, 'Emirates'), 
(0, 'Qantas');
select * from pk_airlines;

-- You cannot reset the auto-increment counter to the start value less or equal than the current maximum ID:
ALTER TABLE pk_airlines AUTO_INCREMENT = 1;
INSERT INTO pk_airlines (name) VALUES ('US Airways'); -- it won't increment from 1
select * from pk_airlines;
SELECT LAST_INSERT_ID();

-- After you have deleted all rows, the counter is not automatically reset to the start value:
DELETE FROM pk_airlines; -- delete all the rows in the table
INSERT INTO pk_airlines (name) VALUES ('United');
SELECT LAST_INSERT_ID();
select * from pk_airlines;

-- You can restart the auto-increment to 1 if there are no rows in a table:
DELETE FROM pk_airlines;
ALTER TABLE pk_airlines AUTO_INCREMENT = 1;
INSERT INTO pk_airlines (name) VALUES ('United'); 
select * from pk_airlines;
