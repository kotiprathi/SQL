use ineuron_fsda;

drop table CASC_Employee;
drop table casc_Payment;

CREATE TABLE casc_Employee 
(
emp_id int(10) NOT NULL,
name varchar(40) NOT NULL,
birthdate date NOT NULL,
gender varchar(10) NOT NULL,
hire_date date NOT NULL,
PRIMARY KEY (emp_id)
);

INSERT INTO casc_Employee (emp_id, name, birthdate, gender, hire_date) 
VALUES
(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'),
(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'),
(103, 'Mike', '1984-10-13', 'M', '2017-10-28'),
(104, 'Daren', '1979-04-11', 'M', '2006-11-01'),
(105, 'Marie', '1990-02-11', 'F', '2018-10-12');

SELECT * FROM casc_Employee;

CREATE TABLE casc_Payment 
(
payment_id int(10) PRIMARY KEY NOT NULL,
emp_id int(10) NOT NULL,
amount float NOT NULL,
payment_date date NOT NULL,
FOREIGN KEY (emp_id) REFERENCES casc_Employee (emp_id) ON DELETE CASCADE ON UPDATE CASCADE
-- ask this before implementing
);

INSERT INTO casc_Payment (payment_id, emp_id, amount, payment_date) 
VALUES
(301, 101, 1200, '2015-09-15'),
(302, 101, 1200, '2015-09-30'),
(303, 101, 1500, '2015-10-15'),
(304, 101, 1500, '2015-10-30'),
(305, 102, 1800, '2015-09-15'),
(306, 102, 1800, '2015-09-30');

SELECT * FROM casc_Payment;

create table pk_cascade_master_table as
select emp.emp_id, emp.name, emp.birthdate, emp.gender, emp.hire_date, pay.payment_id, pay.amount, pay.payment_date
from casc_Employee as emp 
left outer join casc_payment as pay on emp.emp_id = pay.emp_id; 

select * from pk_cascade_master_table;

-- deleting data from employee
DELETE FROM casc_Employee WHERE emp_id = 102;

DELETE FROM casc_Payment WHERE emp_id = 101;

SELECT * FROM casc_Employee;
SELECT * FROM casc_Payment;

USE ineuron_fsda;
USE information_schema;

SELECT table_name FROM referential_constraints
WHERE constraint_schema = 'ineuron_fsda'
AND referenced_table_name = 'casc_Employee'
AND delete_rule = 'CASCADE';

-- -------ON UPDATE CASCADE--------------------
ALTER TABLE casc_Payment ADD CONSTRAINT `payment_fk` -- alter is not working properly
FOREIGN KEY(emp_id) REFERENCES casc_Employee (emp_id) ON UPDATE CASCADE;

describe casc_payment;

UPDATE casc_Employee 
SET emp_id = 109 WHERE emp_id = 101;

UPDATE casc_Employee 
SET emp_id = 110 WHERE emp_id = 102;

SELECT * FROM casc_Employee;
SELECT * FROM casc_Payment;


