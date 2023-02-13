use sql_database;

create table course_trigger(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date );

create table course_update(
course_mentor_update varchar(50),
course_price_update int,
course_discount_update int);

delimiter $$
create trigger course_before_insert
before insert
on course_trigger for each row
begin
	set new.create_date = sysdate();
end; $$ 

select * from course_trigger;

insert into course_trigger values(101,'FSDA','Koti',30000,10);

-- run this query before running trigger
insert into course_trigger (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,"FSDA","sudhanshu",4000,10)
-- after inserting one one or more records then execute the trigger query after that try to insert the values into table 
-- without specifying the trigger column, then automatically the query which we set in trigger will refelect into our table

select * from course_trigger;

create table course_trigger1(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date,
user_info varchar(40));

insert into course_trigger1 (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,"FSDA","sudhanshu",4000,10);

delimiter $$
create trigger course_before_insert1
before insert
on course_trigger1 for each row
begin
	declare user_val varchar(50);
	set new.create_date = sysdate();
    select user() into user_val;
    set new.user_info = user_val;
end; $$ 

insert into course_trigger1 (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,"FSDA","sudhanshu",4000,10);
select * from course_trigger1;