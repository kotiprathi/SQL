use sql_database;

-- before insert
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

create table course_trigger2(
course_id int,
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date,
user_info varchar(40));

insert into course_trigger2 (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,"FSDA","sudhanshu",4000,10);
select * from course_trigger2;

create table ref_course(
record_insert_date date,
record_insert_user varchar(50));

select * from ref_course;

delimiter $$
create trigger course_before_insert2
before insert
on course_trigger2 for each row
begin
	declare user_val varchar(50);
	set new.create_date = sysdate();
    select user() into user_val;
    set new.user_info = user_val;
    insert into ref_course values(sysdate(),user_val);
end; $$ 

insert into course_trigger2 (course_id,course_desc,course_mentor,course_price,course_discount)
value(101,"FSDA","sudhanshu",4000,10);
select * from course_trigger2;
select * from ref_course;


create table test1(
c1 varchar(50),
c2 date,
c3 int);

create table test2(
c1 varchar(50),
c2 date,
c3 int );

create table test3(
c1 varchar(50),
c2 date,
c3 int );

insert into test1 values('koti',sysdate(),5197);
select * from test1;
select * from test2;
select * from test3;

delimiter &&
create trigger to_update_others
before insert on test1 for each row
begin
	insert into test2 values('xyz',sysdate(),2334);
    insert into test3 values('abc',sysdate(),1223);
end; &&

insert into test1 values('koti',sysdate(),5197);

select * from test1;
select * from test2;
select * from test3;

-- after insert

select * from test1;
select * from test2;
select * from test3;

delimiter &&
create trigger to_update_other_tabels
after insert on test1 for each row
begin
	update test2 set c1='abc' where c1='xyz';
    delete from test3 where c1='abc';
end; &&

insert into test1 values('chinni',sysdate(),1097);
select * from test1;
select * from test2;
select * from test3;

-- after delete
select * from test1;

delimiter &&
create trigger to_delete_others_after
after delete on test1 for each row
begin
	insert into test3 values('after delete',sysdate(),1234);
end; &&

delete from test1 where c1='chinni';

select * from test3;

-- before delete
select * from test1;

delimiter &&
create trigger to_delete_others_before
after delete on test1 for each row
begin
	insert into test3 values('before delete',sysdate(),00001);
end; &&

delete from test1 where c1='koti';
select * from test3;

-- only for obsevation of delete trigger

create table test11(
c1 varchar(50),
c2 date,
c3 int);

create table test12(
c1 varchar(50),
c2 date,
c3 int );

create table test13(
c1 varchar(50),
c2 date,
c3 int );

insert into test11 values('koti',sysdate(),23445);
insert into test11 values('chinni',sysdate(),23445);
insert into test11 values('vandu',sysdate(),23445);

select * from test11;

delimiter &&
create trigger to_delete_others_before_obser
before delete on test11 for each row
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2, old.c3);
end; &&

delete from test11 where c1='koti';

select * from test11;
select * from test12;  -- before deleting the test11 value it will insert into test12 table and delete the values


delimiter &&
create trigger to_delete_others_after_obser
after delete on test11 for each row
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2, old.c3);
end; &&

delete from test11 where c1='vandu';  -- two triggers are active for test11 table i.e before and after delete

select * from test11;
select * from test12; 

-- after update
select * from test11;

delimiter &&
create trigger to_update_others_after
after update on test11 for each row
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2, old.c3);
end; &&

update test11 set c1='after update' where c1='koti';

select * from test11;
select * from test12;

-- before update
select * from test11;

delimiter &&
create trigger to_update_others_before
before update on test11 for each row
begin
	insert into test12(c1,c2,c3) values(new.c1, new.c2, new.c3);
end; &&

update test11 set c1='before update' where c1='chinni';

select * from test11;
select * from test12;


-- CASE--

select * from ineuron_partition;

select * ,
case 
	when course_name = 'fsda' then sysdate()
    when course_name = 'fsds' then system_user()
    else "this is not your batch"
end as statement 
from ineuron_partition;

select * ,
case 
	when length(course_name) = 4  then "len 4"
    when length(course_name)= 2  then "len 2"
    else "other lenght"
end as statement 
from ineuron_partition;

update ineuron_partition set course_name = case 
	when course_name = 'RL' then 'reinforcement learing'
	when course_name = 'dl' then 'deep learning'
    else course_name
end;

select * from ineuron_partition;