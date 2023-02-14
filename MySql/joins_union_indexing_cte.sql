use sql_database;

create table if not exists course(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50)
);

create table if not exists student(
student_id int,
student_name varchar(40),
student_mobile int,
student_course_enroll varchar(30),
student_course_id int
);

insert into course values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language');

insert into student values(301 , "sudhanshu", 3543453,'yes', 101),
(302 , "sudhanshu", 3543453,'yes', 102),
(301 , "sudhanshu", 3543453,'yes', 105),
(302 , "sudhanshu", 3543453,'yes', 106),
(303 , "sudhanshu", 3543453,'yes', 101),
(304 , "sudhanshu", 3543453,'yes', 103),
(305 , "sudhanshu", 3543453,'yes', 105),
(306 , "sudhanshu", 3543453,'yes', 107),
(306 , "sudhanshu", 3543453,'yes', 103);

select * from course;
select * from student;

select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
inner join student s on c.course_id = s.student_course_id;

select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
left join student s on c.course_id = s.student_course_id;

select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
left join student s on c.course_id = s.student_course_id where s.student_id is null;

select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
right join student s on c.course_id = s.student_course_id;

select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
right join student s on c.course_id = s.student_course_id where c.course_id is null;

-- cross join give combination of both the tables
select c.course_id, c.course_name, c.course_desc, s.student_id,s.student_name,s.student_course_id from course c
cross join student s;

-- indexing
show index from course;

create table if not exists course1(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50),
index(course_id)
);
-- it will search the records using binary tree. used for optimization of a query
show index from course1;

insert into course1 values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language');

create table if not exists course2(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50),
index(course_id, course_name)
);
show index from course2;

create table if not exists course3(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50),
index(course_desc, course_name)
);
show index from course3;

create table if not exists course4(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50),
index(course_desc, course_name, course_tag)
);
show index from course4;

insert into course4 values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language');

select * from course4 where course_id = 106;
-- click on execution plan after running above query then it will show some visualisation

EXPLAIN ANALYZE select * from course4 where  course_id = 106 or course_name = 'fsds';

EXPLAIN select * from course4 where  course_id = 106;

create table if not exists course5(
course_id int,
course_name varchar(30),
course_desc varchar(50),
course_tag varchar(50),
unique index(course_desc,course_name)
);
show index from course5;

-- unions
select course_id , course_name from course 
union 
select student_id , student_name from student;
-- number of columns should always be equal
-- union will remove duplicate values

select course_desc , course_name from course 
union 
select student_id , student_name from student ;


select course_desc , course_name from course 
union all 
select student_id , student_name from student ;
-- union all won't remove any duplicates

-- CTE(common table expression)
with sample_students as(
select * from course where course_id in (101,102,103))
select * from sample_students where course_tag='java';

with outcome_cross as (select c.course_id , c.course_name , c.course_desc ,s.student_id,s.student_name ,s.student_course_id from course c
cross  join student s ) select course_id , course_name ,student_id from outcome_cross where student_id = 301;

with cte_test as(
select 1 as col1, 2 as col2
union 
select 3,4) select col1 from cte_test;

with recursive cte(n) as(
select 1 union all select n+1 from cte where n<5)
select * from cte;

with recursive koti as(
select 1 as n , 1 as p, -1 as q
union all
select n+1, p+1, q+2 from koti where n<5)
select * from koti;