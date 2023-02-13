create database primary_foriegn;
use primary_foriegn;

CREATE TABLE INEURON(
COURSE_ID INT NOT NULL,
COURSE_NAME VARCHAR(60),
COURSE_STATUS VARCHAR(40),
NUMBER_OF_ENROL INT,
PRIMARY KEY(COURSE_ID));

INSERT INTO INEURON VALUES(01,'FSDA','ACTIVE','100');
INSERT INTO INEURON VALUES(02,'FSDS','INACTIVE','200');

SELECT * FROM INEURON;

CREATE TABLE STUDENTS_INEURON(
STUDENT_ID INT,
COURSE_NAME VARCHAR(60),
STUDENT_MAIL VARCHAR(60),
STUDENT_STATUS VARCHAR(40),
COURSE_ID1 INT,
FOREIGN KEY(COURSE_ID1) REFERENCES INEURON(COURSE_ID));

INSERT INTO STUDENTS_INEURON VALUES(101,'FSDA','TEST@GMAIL.COM','ACTIVE',05); -- ERROR
INSERT INTO STUDENTS_INEURON VALUES(101,'FSDA','TEST@GMAIL.COM','ACTIVE',01);
INSERT INTO STUDENTS_INEURON VALUES(102,'FSDA','TEST1@GMAIL.COM','ACTIVE',01);
INSERT INTO STUDENTS_INEURON VALUES(103,'FSDA','TEST2@GMAIL.COM','ACTIVE',01);

SELECT * FROM STUDENTS_INEURON;

CREATE TABLE PAYMENT(
COURSE_NAME VARCHAR(60),
COURSE_ID INT,
COURSE_LIVE_STATUS VARCHAR(20),
COURSE_LAUNCH_DATE VARCHAR(20),
FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID));

INSERT INTO PAYMENT VALUES('FSDA',06,'NOT ACTIVE','12-11-2022'); -- ERROR BECAUSE COURSE_ID 6 IS NOT AVAILABLE IN COURSE_ID OF INEURON TABLE
INSERT INTO PAYMENT VALUES('FSDA',01,'ACTIVE','12-11-2022');
INSERT INTO PAYMENT VALUES('FSDA',01,'ACTIVE','12-11-2022');

SELECT * FROM PAYMENT;

CREATE TABLE CLASS(
COURSE_ID INT,
CLASS_NAME VARCHAR(40),
CLASS_TOPIC VARCHAR(40),
CLASS_DURATION INT,
PRIMARY KEY(COURSE_ID),
FOREIGN KEY(COURSE_ID) REFERENCES INEURON(COURSE_ID));

-- ADDING ANOTHER PRIMARY KEY TO EXISTING COLUMN INSIDE INEURON TABLE
ALTER TABLE INEURON
ADD constraint TEST_PRIM PRIMARY KEY(COURSE_ID,COURSE_NAME); -- THIS WILL NOT ALLOW TO ADD ONE MORE PRIMARY KEY BECAUSE ALREADY ONE PRIMARY KEY EXISTS

ALTER TABLE ineuron
DROP PRIMARY KEY;  -- WE CANNOT DELETE BECAUSE IT IS CONNECTED TO FOREIGN KEY OTHERWISE WE CAN DELETE THE PRIMARY KEY


---------------------------------------------------------
-- for one table we cannot create multiple primary keys, but we can create one primary which contains combination of multiple column
CREATE TABLE TEST(
ID INT NOT NULL,
NAME VARCHAR(30),
EMAIL_ID VARCHAR(40),
MOBILE_NO VARCHAR(20),
ADDRESS VARCHAR(20));
-- adding primary key for the first time to the existing column
ALTER TABLE TEST ADD PRIMARY KEY(ID);

-- adding another primary key to the existing column
ALTER TABLE TEST DROP PRIMARY KEY;
ALTER TABLE TEST ADD CONSTRAINT TEST_PRIM PRIMARY KEY(ID,EMAIL_ID);

-----------------------------------------------------------------
create table parent(
id int not null,
primary key(id));

create table child(
id int,
parent_id int,
foreign key(parent_id) references parent(id));

insert into parent values(1),(2);
select * from parent;

insert into child values(1,1);
select * from child;
insert into child values(1,3); -- it will give error

-- deleting the record from parent table
delete from parent where id = 1;  -- it will give error because it is associated with another table child
-- but still if we want to delete the record from parent table 
-- one way is to delete the child records first and then delete the parent table record
delete from child where id = 1;
delete from parent where id = 1;

-- second way to delete the parent table records using cascade
drop table child;

create table child(
id int,
parent_id int,
foreign key(parent_id) references parent(id) on delete cascade);  -- update the child table whenever there is a delete happened in parent table
insert into child values(1,1),(1,2),(2,2),(3,2);

select * from child;

delete from parent where id = 1; -- after deleting the record key in parent table then it will automatically affect the child table
select * from parent;

-------------------------------------------
drop table child;

create table child(
id int,
parent_id int,
foreign key(parent_id) references parent(id) on update cascade);  

insert into child values(1,2),(2,2),(3,2);
select * from child;

update parent 
set id=3 where id=2;

select * from parent;  -- id is updated to 3
select * from child;   -- id is updated to 3 in child table also because of cascade


