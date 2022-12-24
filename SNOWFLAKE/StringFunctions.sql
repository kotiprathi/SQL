use warehouse SQL_WAREHOUSE;
use database SQL_DATABASE;

CREATE OR REPLACE TABLE PK_AGENTS
(
    AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY,
    AGENT_NAME CHAR(40),
    WORKING_AREA CHAR(35),
    COMMISSION NUMBER(10,2) default 0.05,
    PHONE_NO CHAR(15),
    COUNTRY VARCHAR2(25)
);

DESCRIBE TABLE PK_AGENTS;
INSERT INTO PK_AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
INSERT INTO PK_AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');


INSERT INTO PK_AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
INSERT INTO PK_AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
INSERT INTO PK_AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
INSERT INTO PK_AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
INSERT INTO PK_AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
INSERT INTO PK_AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
INSERT INTO PK_AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
INSERT INTO PK_AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
INSERT INTO PK_AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
INSERT INTO PK_AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
INSERT INTO PK_AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');

SELECT DISTINCT * FROM PK_AGENTS;

----SET THE COUNRTY TO 'INDIA' WHEREVER COUNTRY IS NULL OR BLANK----
UPDATE PK_AGENTS
SET COUNTRY = 'INDIA' WHERE COUNTRY IS NULL OR COUNTRY = '';

/* THE SUBSTRING() FUNCTION RETURNS THE POSITION OF A STRING OR BINARY VALUE FROM THE COMPLETE STRING.
STARTING WITH THE CHARACTER SPECIFIED BY SUBSTRING START_INDEX */

--EXAMPLE 1: GET THE SUBSTRING FROM A SPECIFIC STRING
SELECT SUBSTRING('PRATHI KOTESWARA RAO',1,8) AS PARTIAL_NAME;
SELECT SUBSTRING('PRATHI KOTESWARA RAO',4,8);  -- second argument specifies the length
SELECT SUBSTR('CHINNI',0,3); -- (O TO N-1)
SELECT SUBSTR('CHINNI',3);   -- INDEX 3 TO END

SELECT SUBSTR('CHINNI',-5);    -- START FROM -5 INDEX TO END
SELECT SUBSTR('CHINNI',-5,3);  -- START FROM -5 INDEX TO NEXT 3 CHARACTERS FROM THAT INDEX
SELECT SUBSTR('CHINNI',-5,-1); -- NO OUTPUT
SELECT SUBSTR('CHINNI',NULL);

-- Get the first character from each word in the string
SELECT CONCAT(SUBSTRING('PRATHI KOTESWARA RAO',1,1),SUBSTRING('PRATHI KOTESWARA RAO',8,1),
              SUBSTRING('PRATHI KOTESWARA RAO',18,1));
select concat('prathi','koteswara','rao');
SELECT SUBSTRING('PRATHI KOTESWARA RAO',1,1)||SUBSTRING('PRATHI KOTESWARA RAO',8,1)||
              SUBSTRING('PRATHI KOTESWARA RAO',18,1);

-- To return the length of the string INCLUDING SPACE--
SELECT LEN('CHINNI ') AS NAME_LENGTH;

-- Get the substring from a specific string using table data --
SELECT DISTINCT *,SUBSTR(AGENT_CODE,2) AS AGENT_INITIALS FROM PK_AGENTS;
SELECT DISTINCT AGENT_NAME,AGENT_CODE,SUBSTR(AGENT_CODE,1,3) AS AGENT_INITIALS FROM PK_AGENTS;

-- Combining two columns using concat or ||  --
SELECT CONCAT(AGENT_CODE,AGENT_NAME) AS AGENT_DETAILS FROM PK_AGENTS;
SELECT AGENT_CODE||' '||AGENT_NAME FROM PK_AGENTS;

-----TYPE CASTING-----------------
SELECT CAST('1.6845' AS DECIMAL(4,3));
SELECT '1.6845'::DECIMAL(2);

---when the provided precision is insufficient to hold the input value, the snowflake CAST command raises an error as follows
--here precision is set as 4 but the input value has total of 5 digits, thereby raising the error
SELECT CAST('123.12' AS DECIMAL(4,2));

SELECT CAST('123.12' AS DECIMAL(5,2));
SELECT CAST('123.12' AS DECIMAL(4,1));

SELECT CAST('12-DEC-2022' AS TIMESTAMP);
SELECT CAST('2022-12-22' AS TIMESTAMP);
SELECT CAST('12-22-2022' AS TIMESTAMP); -- THIS WILL GIVE ERROR(BECAUSE IT IS NOT IN RIGHT FORMAT)

SELECT TRY_CAST('ANAND' AS char(4)); -- it will return NULL instead of error

------TRIM-------
SELECT LTRIM('#00000CHINNI','0#');
SELECT LTRIM('******9693','*');

SELECT RTRIM('KOTI*****#','#*');
SELECT RTRIM('$125.00','0.');

SELECT LEN(TRIM('  KOTESWARA RAO     '));

--REVERSE
SELECT REVERSE('KOTESWARA RAO');

--SPLIT
SELECT SPLIT('PRATHI-KOTESWARA-RAO','-');
SELECT SPLIT('PRATHI-KOTESWARA-RAO','-')[1];
SELECT SPLIT('123.9.0','.');

SELECT SPLIT_PART('PRATHI-KOTESWARA-RAO','-',1);  -- 1 IS INDEX VALUE
SELECT SPLIT_PART('PRATHI-KOTESWARA-RAO','-',3);
SELECT SPLIT_PART('PRATHI-KOTESWARA-RAO','-',-2); -- INDEX CALCULATED FROM LAST
-----------------------------------------------------
CREATE OR REPLACE TABLE PK_PERSONS(
NAME VARCHAR2(20),
CHILDREN VARCHAR2(50)
);
INSERT INTO PK_PERSONS
VALUES('MARK','MARKY,MARK,JULIA'),('JOHN','JONNY,JANE');
SELECT * FROM PK_PERSONS;

SELECT SPLIT(CHILDREN,',') FROM PK_PERSONS;
--FLATTEN 
SELECT NAME,CHINNI.VALUE::STRING AS CHILDNAME FROM PK_PERSONS,
LATERAL FLATTEN(INPUT=>SPLIT(CHILDREN,',')) CHINNI;
--------------------------------------------------------------
--COMBINING SPLIT AND CONCAT
SELECT SPLIT(AGENT_DETAILS,'-') FROM (SELECT *,CONCAT(AGENT_CODE,'-',AGENT_NAME) AS AGENT_DETAILS FROM PK_AGENTS);

------LOWER & UPPER
SELECT LOWER('India Is My Country') as lwr_string;
select upper('India Is My Country') as upr_string;

select upper(concat(substring('prathi koteswara rao',1,1),
                   substring('prathi koteswara rao',8,1),
                   substring('prathi koteswara rao',18,1)));
                   
------INITCAP
SELECT INITCAP('PRATHI KOTESWARA RAO');
SELECT INITCAP('PRATHI KOTESWARA RAO','');
SELECT INITCAP('this is my frame+work','+');  // after delimiter(+) it will make the first letter capital
SELECT INITCAP('this is my frame+work',' ');
SELECT INITCAP('iqamqinterestedqinqthisqtopic','q'); // every subsequent character after q will gets capitalized

------REPLACE COMMAND
SELECT REPLACE('  KOTESWARA RAO   ',' ','*');
SELECT REPLACE('  KOTESWARA RAO   ',' ');   // REPLACE ALL THE WHITE SPACE CHARACTERS WITH NULL(means whitespaces are removed)
select replace('abcd','bc');

------STARTSWITH
SELECT DISTINCT * FROM PK_AGENTS;

SELECT * FROM PK_AGENTS WHERE STARTSWITH(AGENT_NAME,'R');

-----RIGHT
SELECT RIGHT('ABCDEFG',3);  -- it will take 3 characters from the right(last)
SELECT LEFT('ABCDEFG',4);   -- it will take 4 characters from the left(starting)

-----CONTAINS
SELECT DISTINCT * FROM PK_AGENTS WHERE CONTAINS(COMMISSION,0.15);

----EX:
SELECT UPPER(CONCAT(AGENT_CODE,'-',AGENT_NAME)) AS AGENT_DETAILS,
       LEFT(COUNTRY,2) AS COUNTRY_CODE,
       SUBSTRING(AGENT_CODE,-3) AS AGENT_NUMBER FROM PK_AGENTS;

-----NVL
--nvl is widely used to replace fisrt argument if the value is null with value specified in second argument

select nvl('food','bread') as col,
       nvl(null,3.14) as col2;  -- if first argument is null then it will replace it with 3.14
       
------COALESCE
---it will always return the first non-null value specified in the collasce argument
---and all the arguments in collasce must have same data type
select column1,column2,column3, 
coalesce(column1,column2,column3) as extracted_values
from 
(values
     ('koti','india',null),
     (null,'chinni','guntur')
)v;
