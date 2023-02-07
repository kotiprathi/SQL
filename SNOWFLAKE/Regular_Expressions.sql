/* Snowflake REGEXP_COUNT Function
The REGEXP_COUNT function searches a string and returns an integer that indicates the number of 
times the pattern occurs in the string. If no match is found, then the function returns 0.

syntax : REGEXP_COUNT( <string> , <pattern> [ , <position> , <parameters> ] ) */ 

select regexp_count('It was the best of times, it was the worst of times', '\\bwas\\b', 1,'i') as "result"; -- i enables case insenstive-matching
select regexp_count('It was the best of times, it was the worst of times', '\\bit\\b', 1,'i') as "result";  --  \\b is line break(space)

select regexp_count('qqqabcrtrababcbcd', 'abc');
select regexp_count('qqqabcrtrababcbcd', '[abc]');

create or replace table overlap (id number, text string);
insert into overlap values (1,',abc,def,ghi,jkl,');
insert into overlap values (2,',abc,,def,,ghi,,jkl,');
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[AB]{2}'); --ABSOLUTELY FINE
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[T]{2}'); --ABSOLUTELY FINE
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[Q]{2}');

select * from overlap;

select id, regexp_count(text,'[[:punct:]][[:alnum:]]+[[:punct:]]', 1, 'i') from overlap;
/*
--the count of first punctuation+ the count of other punctuatiuon+alphabaets is given as result
,abc, is 1st count 
def - not counted
,ghi, - 2nd counted
jkl, - is not counted - total 2
*/
/*
The Snowflake REGEXP_REPLACE function returns the string by replacing specified pattern. 
If no matches found, original string will be returned.

Following is the syntax of the Regexp_replace function.

REGEXP_REPLACE( <string> , <pattern> [ , <replacement> , <position> , <occurrence> , <parameters> ] )

1. Extract date from a text string using Snowflake REGEXP_REPLACE Function
The REGEXP_REPLACE function is one of the easiest functions to get the required value when manipulating strings data.
Consider the below example to replace all characters except the date value. */

--For example, consider following query to return only user name.
/*
* maches zero or more characters
.  matches all characters except null
\s white space character
\w word character
\W not word character
\b word boundary
\B not word boundary
*/
select regexp_replace('anandjha2309@gmail.com','@.*\\.(com)');
select regexp_replace('anandjha_1990@yahoo.com', '@.*\\.(com)');
select regexp_replace('anandjha2309@gmail.com','@.*');

select regexp_replace('Customers - (NY)','\\(|\\)','') as customers; --| is OR, \\ is space 
select regexp_replace( 'vk73742@gmail.co.in', '@.*\\.(co).(in)');

SELECT TRIM(REGEXP_REPLACE(string, '[a-z/-/A-Z/.]', ''))AS date_value 
FROM (SELECT 'My DOB is 04-12-1976.' AS string) a;

select REGEXP_REPLACE(string, '[a-z/-/A-Z\.]', '') from (SELECT 'My DOB is 04-12-1976.' AS string);

select regexp_replace('acd@gmail.com.IN','@.*');

select regexp_replace('firstname middlename lastname','(.*) (.*) (.*)','\\3, \\1 \\2') as "name sort" from dual;

-- REGEXP_LIKE
create or replace table cities(city varchar(20));
insert into cities values
    ('Sacramento'),
    ('San Francisco'),
    ('San Jose'),
    (null);

SELECT * FROM cities;

select * from cities where regexp_like(city, 'san.*','i');

WITH tbl
  AS (select t.column1 mycol 
      from values('A1 something'),('B1 something'),('Should not be matched'),('C1 should be matched') t )

SELECT * FROM tbl WHERE regexp_like (mycol,'[a-zA-z]\\d{1,}[\\s0-9a-zA-Z]*');
--second word start with small s

-- REGEX_INSTR
-- returns the index position of searching pattern
CREATE or replace TABLE demo1 (id INT, string1 VARCHAR);
INSERT INTO demo1 (id, string1) VALUES 
    (1, 'nevermore123, nevermore24, nevermore34567.')
    ;
select * from demo1;

select id, string1, regexp_instr( string1, 'nevermore\\d') AS "POSITION" from demo1;  -- \\d is the digit
    
select id, string1, regexp_instr( string1, 'nevermore\\d', 5) AS "POSITION" from demo1;  -- start searching the match from 5th character

select id, string1, regexp_instr( string1, 'nevermore\\d', 1, 3) AS "POSITION" from demo1; -- look for the 3rd match rather than 1st match
 
select id, string1, 
       regexp_instr( string1, 'nevermore\\d', 1, 3, 0) AS "START_POSITION",
       regexp_instr( string1, 'nevermore\\d', 1, 3, 1) AS "AFTER_POSITION"
    from demo1;
    
-- Extract date using REGEXP_SUBSTR 
-- eturns the substring that matches a regular expression within a string, if no macth is found them returns null
--Alternatively, REGEXP_SUBSTR function can be used to get date field from the string data. 

CREATE or replace TABLE demo2 (id INT, string1 VARCHAR);
INSERT INTO demo2 (id, string1) VALUES 
    -- A string with multiple occurrences of the word "the".
    (2, 'It was the best of times, it was the worst of times.'),
    -- A string with multiple occurrences of the word "the" and with extra
    -- blanks between words.
    (3, 'In    the   string   the   extra   spaces  are   redundant.'),
    -- A string with the character sequence "the" inside multiple words 
    -- ("thespian" and "theater"), but without the word "the" by itself.
    (4, 'A thespian theater is nearby.')
    ;

select * from demo2;

select id, regexp_substr(string1, 'the\\W+\\w+') as "RESULT" from demo2 order by id; -- looking for first match
select id, regexp_substr(string1, 'the\\W+\\w+',1,2) as "RESULT" from demo2 order by id; -- starting from position1 and looking for second match

select id, string1, regexp_substr(string1, 'the\\W+\\w+', 1, 2) as "SUBSTRING",
       regexp_instr(string1, 'the\\W+\\w+', 1, 2) as "POSITION" from demo2 order by id;
    
select id, string1, regexp_substr(string1, 'the\\W+(\\w+)', 1, 2,'e', 1) as "SUBSTRING"  
-- 'e' stands for extract submatches the parameter which stands in paranthesis
-- regexp_instr( string1, 'the\\W+(\\w+)', 1, 2, 0, 'e', 1) as "POSITION"
from demo2 order by id;

CREATE or replace TABLE demo3 (id INT, string1 VARCHAR);
INSERT INTO demo3 (id, string1) VALUES (5, 'A MAN A PLAN A CANAL');

SELECT * FROM DEMO3;
    
select id, 
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 1, 'e', 1) as "RESULT1",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 2, 'e', 1) as "RESULT2",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 3, 'e', 1) as "RESULT3",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 4, 'e', 1) as "RESULT4"
    from demo3;
