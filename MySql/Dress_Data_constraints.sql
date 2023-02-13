show databases;
create database SQL_DATABASE;
USE SQL_DATABASE;

create table if not exists dress_data(
`Dress_ID` varchar(30),	
`Style`	varchar(30),	
`Price`	varchar(30),	
`Rating` varchar(30),	
`Size` varchar(30),	
`Season` varchar(30),	
`NeckLine` varchar(30),	
`SleeveLength` varchar(30),		
`waiseline`	varchar(30),	
`Material` varchar(30),	
`FabricType` varchar(30),	
`Decoration` varchar(30),	
`Pattern Type` varchar(30),		
`Recommendation` varchar(30) );

LOAD DATA INFILE 'C:/Data Analytics/MySql_sudhanshu/Data sets/AttributeDataSet.csv'
into table dress_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM dress_data;

create table if not exists test(
test_id int auto_increment,  # constraint - auto_increment
test_name varchar(30),
test_mailid varchar(30),
teast_adress varchar(30),
primary key (test_id))

select * from test;

insert into test (test_name,test_mailid,teast_adress)values('raju','raju@gmail.com','chennai'),
('chinni','chinni@gmail.com','guntur'),
('jimmy','jimmy@hcl.com','banglore');

use ineuron_fsda;
# this table is created in ineuron_fsda

create table if not exists test2(
test_id int,
test_name varchar(30),
test_mailid varchar(30),
teast_adress varchar(30),
test_salary int check(test_salary>10000)); # constraint - check

# it will check whether the salary we are adding into table is greater than 20000. If it is not greater then it will give error
insert into test2 values(1,'raju','raju@gmail.com','chennai',80000),
(2,'chinni','chinni@gmail.com','guntur',20000),
(3,'jimmy','jimmy@hcl.com','banglore',25000);
insert into test2 values (4,'Louis','louis@hcl.com','USA',15000);
select * from test2;

create table if not exists test3(
test_id int,
test_name varchar(30),
test_mailid varchar(30),
teast_adress varchar(30) check(teast_adress='chennai'),
test_salary int check(test_salary>10000));
insert into test3 values(1,'chinni','chinni@gmail.com','chennai',11000);
select * from test3;

alter table test3 add check(test_id>0);
#insert into test3 values(-1,'chinni','chinni@gmail.com','chennai',11000);
insert into test3 values(2,'chinni','chinni@gmail.com','chennai',11000);

create table if not exists test4(
test_id int NOT NULL, # constraint - NOT NULL
test_name varchar(30),
test_mailid varchar(30),
teast_adress varchar(30) check(teast_adress='chennai'),
test_salary int check(test_salary>10000));

select * from test4;
insert into test4 (test_id,test_name,test_mailid,teast_adress,test_salary) values(7,'chinni','chinni@gmail.com','chennai',11000);
# In order to execute the below command we need to keep auto_increment or default for test_id
insert into test4 (test_name,test_mailid,teast_adress,test_salary) values('janu','janu@gmail.com','chennai',15000);

create table if not exists test5(
test_id int NOT NULL default 0, # constraint - default
test_name varchar(30),
test_mailid varchar(30),
teast_adress varchar(30) check(teast_adress='chennai'),
test_salary int check(test_salary>10000));
insert into test5 (test_name,test_mailid,teast_adress,test_salary) values('janu','janu@gmail.com','chennai',15000);
select * from test5;
insert into test5 (test_id,test_name,test_mailid,teast_adress,test_salary) values(101,'janu1','janu@gmail.com','chennai',15000);
insert into test5 (test_name,test_mailid,teast_adress,test_salary) values('sunny','sunny@gmail.com','chennai',55000);

create table if not exists test6(
test_id int NOT NULL default 0, 
test_name varchar(30),
test_mailid varchar(30) unique,  # constraint - unique
teast_adress varchar(30) check(teast_adress='chennai'),
test_salary int check(test_salary>10000));
insert into test6 (test_name,test_mailid,teast_adress,test_salary) values('sunny','sunny@gmail.com','chennai',55000);
select * from test6;
insert into test6 (test_name,test_mailid,teast_adress,test_salary) values('sunny','sunny@gmail.com','chennai',55000);

# combining all constraints
create table if not exists test8(
test_id int NOT NULL auto_increment, 
test_name varchar(30) NOT NULL default 'unknown',
test_mailid varchar(30) unique,  # constraint - unique
teast_adress varchar(30) check(teast_adress='chennai'),
test_salary int check(test_salary>10000),
primary key(test_id));

select * from test8;
insert into test8 (test_id,test_name,test_mailid,teast_adress,test_salary) values(1,'sunny','sunny@gmail.com','chennai',55000);
insert into test8 (test_name,test_mailid,teast_adress,test_salary) values('sunny','sunny1@gmail.com','chennai',55000);
insert into test8 (test_mailid,teast_adress,test_salary) values('chinni@gmail.com','chennai',55000);
insert into test8 (test_id,test_name,test_mailid,teast_adress,test_salary) values(20,'tinny','tinny@gmail.com','chennai',20000);
insert into test8 (test_mailid,teast_adress,test_salary) values('gary@gmail.com','chennai',30000);


