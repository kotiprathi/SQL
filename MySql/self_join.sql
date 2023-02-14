create database joins;
use joins;

create table student 
(
student_id int ,
name varchar(20),
course_id int,
duration int);

insert into student 
values
(1,'adam',1,3),
(2,'peter',2,4),
(1,'adam',2,4),
(3,'brian',3,2),
(2,'shane',3,5);

select * from student;

-- go with this
SELECT distinct s1.student_id, s1.name
FROM student AS s1, student s2
WHERE s1.student_id=s2.student_id
AND s1.course_id <> s2.course_id;

-- self join using inner join
SELECT s1.student_id, s1.name
FROM student s1
INNER JOIN student s2
ON s1. student_id = s2.student_id AND s1.course_id <> s2.course_id
GROUP BY 1,2;

CREATE TABLE Persons 
(PersonID int NOT NULL PRIMARY KEY,
LastName varchar(255) NOT NULL, 
FirstName varchar(255),
ReportsTo int, 
Title varchar(255),
Salary decimal);

insert into Persons 
values (1,'Jha','Anand',8,'Data Analyst',1200000),
       (8,'M','Sangeetha',10,'Manager',4500000),
       (2,'Chaturvedi','Ishan',8,'Data Scientist',1800000),
       (10,'Shekhar','Srinu',123,'Tech Lead',2300000),
       (4,'MESHRAM','VINEET',10,'Consultant',1200000),
       (123,'Goel','Neha',134,'Manager',40000000),
       (20,'kumar','sathish', 18,'Data Engineer',8000000),
       (18,'GUPTA','ANKITA',10,'Business Architect',1100000),
       (7, 'Yadav', 'Abhishek', 10, 'Data Analyst',1000000),
       (134,'Dixit','Nitesh',27,'VP',20000000),
       (27,'Bandekar','Kalpana',32,'CEO',50000000);

select * from Persons;

-- list of employees who reports to same manager
select distinct p1.PersonId as emp_id, concat(p1.firstName," ", p1.lastName) as emp_fullname, p2.ReportsTo as manager_id
from persons as p1, persons as p2
where p1.PersonId <> p2.PersonID and p1.ReportsTo = p2.ReportsTo
order by emp_id,emp_fullname,manager_id;

-- -- list of all the reportee/manager and the number of employees directly reporting to them
select p2.ReportsTo as manager_id,
count(distinct p1.PersonID) as Tot_emp_Reporting
from persons as p1, persons as p2
where p1.PersonId <> p2.PersonID and p1.ReportsTo = p2.ReportsTo
group by 1
order by 1;

-- LIST OF ALL THE EMPLOYEES AND THEIR ASSOCIATED MANAGER
SELECT CONCAT(b.LastName, ', ', b.FirstName) AS 'Direct Reporting' ,
CONCAT (a.FirstName, ' ' , a.LastName) AS Manager
FROM Persons b 
INNER JOIN persons a ON a.PersonID = b.ReportsTo
ORDER BY Manager;

-- LIST OF ALL THE EMPLOYEES AND THEIR ASSOCIATED  MANAGERS IF IT EXISTS
SELECT CONCAT(b.LastName, ', ', b.FirstName) AS 'Direct Reporting' ,
CONCAT (a.FirstName, ' ' , a.LastName) AS Manager
FROM Persons b 
LEFT OUTER JOIN persons a ON a.PersonID = b.ReportsTo
ORDER BY Manager;

SELECT CONCAT (a.FirstName, ' ' , a.LastName) AS Manager,
-- COUNT(CONCAT(b.LastName, ', ', b.FirstName)) AS 'TOT_EMP_REPORTING'
COUNT(a.PersonID)
FROM Persons b 
LEFT OUTER JOIN persons a ON a.PersonID = b.ReportsTo
GROUP BY 1
-- HAVING TOT_EMP_REPORTING >= 2
ORDER BY 2 DESC;

-- successive rows salary comparison
SELECT distinct p1.PersonID, p1.Salary 
-- CONCAT (p1.FirstName, ' ' , p1.LastName) as EMP_NAME, 
FROM Persons AS p1, Persons p2
WHERE p1.Salary < p2.Salary
order by 2 desc;





