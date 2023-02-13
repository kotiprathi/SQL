USE SQL_DATABASE;

CREATE TABLE INEURON_STUDENTS(
STUDENT_ID INT,
STUDENT_BATCH VARCHAR(20),
STUDENT_NAME VARCHAR(40),
STUDENT_STREAM VARCHAR(30),
STUDENT_MARKS INT,
STUDENT_MAIL_ID VARCHAR(50));

INSERT INTO INEURON_STUDENTS VALUES(101,'FSDA','CHINNI','CS',80,'CHINNI@GMAIL.COM'),
(102 ,'fsda' , 'sanket','cs',81,'sanket@gmail.com'),
(103 ,'fsda' , 'shyam','cs',80,'shyam@gmail.com'),
(104 ,'fsda' , 'sanket','cs',82,'sanket@gmail.com'),
(105 ,'fsda' , 'shyam','ME',67,'shyam@gmail.com'),
(106 ,'fsds' , 'ajay','ME',45,'ajay@gmail.com'),
(106 ,'fsds' , 'ajay','ME',78,'ajay@gmail.com'),
(108 ,'fsds' , 'snehal','CI',89,'snehal@gmail.com'),
(109 ,'fsds' , 'manisha','CI',34,'manisha@gmail.com'),
(110 ,'fsds' , 'rakesh','CI',45,'rakesh@gmail.com'),
(111 ,'fsde' , 'anuj','CI',43,'anuj@gmail.com'),
(112 ,'fsde' , 'mohit','EE',67,'mohit@gmail.com'),
(113 ,'fsde' , 'vivek','EE',23,'vivek@gmail.com'),
(114 ,'fsde' , 'gaurav','EE',45,'gaurav@gmail.com'),
(115 ,'fsde' , 'prateek','EE',89,'prateek@gmail.com'),
(116 ,'fsde' , 'mithun','ECE',23,'mithun@gmail.com'),
(117 ,'fsbc' , 'chaitra','ECE',23,'chaitra@gmail.com'),
(118 ,'fsbc' , 'pranay','ECE',45,'pranay@gmail.com'),
(119 ,'fsbc' , 'sandeep','ECE',65,'sandeep@gmail.com');

SELECT * FROM INEURON_STUDENTS;

-- AGGREGATION BASED WINDOW FUNCTION: MIN,MAX,SUM,AVG,COUNT,ETC,.. USING GROUP BY FUNCTION
-- IT WILL TRY TO AGGREGATE THE DATA AND THEN GIVE THE RESULT BASED ON GROUP
SELECT STUDENT_BATCH, SUM(STUDENT_MARKS) FROM INEURON_STUDENTS group by STUDENT_BATCH;
SELECT STUDENT_BATCH, MIN(STUDENT_MARKS) FROM INEURON_STUDENTS group by STUDENT_BATCH;
SELECT STUDENT_BATCH, MAX(STUDENT_MARKS) FROM INEURON_STUDENTS group by STUDENT_BATCH;
SELECT STUDENT_BATCH, AVG(STUDENT_MARKS) FROM INEURON_STUDENTS group by STUDENT_BATCH;
SELECT COUNT(DISTINCT STUDENT_BATCH) FROM INEURON_STUDENTS;
SELECT STUDENT_BATCH, COUNT(STUDENT_BATCH) FROM INEURON_STUDENTS group by STUDENT_BATCH;


-- GET THE NAME OF THE STUDENT WHO SCORES MAXIMUM ALONG WITH HIS MARKS BASED ON STUDENT_BATCH
SELECT * FROM INEURON_STUDENTS;
SELECT STUDENT_NAME,MAX(STUDENT_MARKS) FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA';  -- ERROR, WE CAN USE AGGEGATE FUNCTION ONLY WHEN GROUP BY IS USED

SELECT STUDENT_NAME,STUDENT_MARKS FROM INEURON_STUDENTS WHERE STUDENT_MARKS IN 
(SELECT MAX(STUDENT_MARKS) FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA');

SELECT STUDENT_NAME,STUDENT_MARKS FROM INEURON_STUDENTS WHERE STUDENT_MARKS IN 
(SELECT MAX(STUDENT_MARKS) FROM INEURON_STUDENTS GROUP BY STUDENT_BATCH);

-- SECOND HIGHEST MARKS
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1 OFFSET 1; -- IT WILL GIVE ONLY ONE RECORD OF INDEX 1
-- INDEX STARTS FROM 0, SO SECOND HIGHEST IS INDEX NUMBER 1
-- LIMIT
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,2;  -- IT WILL GIVE 2 RECORDS FROM INDEX 1
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 2;  -- IT WILL GIVE TOP 2 RECORDS
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3;  -- IT WILL GIVE TOP 3 RECORDS

SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 1,2;
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 2,2;

SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 2,1;  -- FROM INDEX 2 IT WILL GIVE 1 RECORD
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3,1;  -- FROM INDEX 3 IT WILL GIVE 1 RECORD
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 4,1;

SELECT * FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 3,2;  -- FROM INDEX 3 IT WILL GIVE 2 RECORDS

-- THIRD HIGHEST
SELECT * FROM INEURON_STUDENTS WHERE STUDENT_MARKS=
(SELECT DISTINCT(STUDENT_MARKS) FROM INEURON_STUDENTS WHERE STUDENT_BATCH='FSDA' ORDER BY STUDENT_MARKS DESC LIMIT 2,1);

-- ANALYTICAL BASED WINDOW FUNCTION: ROW_NUMBER, RANK, DENSE RANK,
-- ROW_NUMBER()
SELECT STUDENT_ID,STUDENT_MARKS,STUDENT_NAME,STUDENT_BATCH,
ROW_NUMBER() OVER(ORDER BY STUDENT_MARKS) AS 'ROW NUM' FROM INEURON_STUDENTS;

SELECT STUDENT_ID,STUDENT_MARKS,STUDENT_NAME,STUDENT_BATCH,
ROW_NUMBER() OVER( PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS) AS 'ROW_NUM' FROM INEURON_STUDENTS;

-- HIGHEST MARKS IN EACH BATCH
SELECT * FROM (SELECT STUDENT_NAME,STUDENT_MARKS,ROW_NUMBER() OVER( PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM'
FROM INEURON_STUDENTS) AS TEST WHERE ROW_NUM=1;
-- but if 2 members have same marks then the above query won't work 
-- Rank()
SELECT STUDENT_NAME,STUDENT_MARKS,RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK'
FROM INEURON_STUDENTS;

SELECT STUDENT_NAME,STUDENT_MARKS,student_batch,
ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM',
RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK' FROM INEURON_STUDENTS;

select * from (SELECT STUDENT_NAME,STUDENT_MARKS,student_batch,
ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM',
RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK' FROM INEURON_STUDENTS) as test where row_rank=1;
-- there is some problem in allocating the rank number in the above queries. that is if two people have same marks 
-- then the rank number is same for two people and the next rank number is not in sequence. In that case dense_rank is used

-- DENSE_RANK()
SELECT STUDENT_NAME,STUDENT_MARKS,student_batch,
ROW_NUMBER() OVER(ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM',
RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK',
DENSE_RANK() OVER(ORDER BY STUDENT_MARKS DESC) AS 'DENSE_RANK' FROM INEURON_STUDENTS;

SELECT STUDENT_NAME,STUDENT_MARKS,student_batch,
ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM',
RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK',
DENSE_RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'DENSE_RANK' FROM INEURON_STUDENTS;

SELECT * FROM (SELECT STUDENT_NAME,STUDENT_MARKS,student_batch,
ROW_NUMBER() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_NUM',
RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'ROW_RANK',
DENSE_RANK() OVER(PARTITION BY STUDENT_BATCH ORDER BY STUDENT_MARKS DESC) AS 'DENSE_RANK_ROW' FROM INEURON_STUDENTS) AS TEST WHERE DENSE_RANK_ROW=4;