use sql_database;

create table ineuron_partition(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)

select * from ineuron_partition;

insert into ineuron_partition values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

select * from ineuron_partition where course_lauch_year=2020;

create table ineuron_partition1(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by range(course_lauch_year)(
partition p0 values less than(2019),
partition p1 values less than(2020),
partition p2 values less than(2021),
partition p3 values less than(2022),
partition p4 values less than(2023));
-- this will try to create a multiple tables internally based on the condition that we mention
-- so whenever if anyone try to search any operation then instead of searching in whole table, 
-- it will search in the small or chunck of tables that we created so that the space becomes small and also time taken is reduced and query is optimized

select * from ineuron_partition1;

insert into ineuron_partition1 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

select * from ineuron_partition1 where course_lauch_year=2020;

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition1';

create table ineuron_partition2(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by hash(course_lauch_year)
partitions 5;
-- it will create 5 seperate tables
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition2';

create table ineuron_partition3(
course_name varchar(50) ,
course_id int(10) , 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by hash(course_lauch_year)
partitions 10;
-- it will create 10 seperate tables
-- year % 10 and based on remainder value it will śeperate
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition3';

insert into ineuron_partition3 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

create table ineuron_partition4(
course_name varchar(50) ,
course_id int(10) primary key, 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by key()
partitions 10;
-- based on MD5 algorithm it will seperate the tables
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition4';

insert into ineuron_partition4 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

select * from ineuron_partition4;
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition4';

create table ineuron_partition5(
course_name varchar(50),
course_id int(10), 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by list(course_lauch_year)(
partition p0 values in(2019,2020),
partition p1 values in(2021,2022)
);

insert into ineuron_partition5 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition5';

create table ineuron_partition6(
course_name varchar(50),
course_id int(10), 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by range columns(course_name,course_id,course_lauch_year)(
partition p0 values less than ('aiops',105,2019),
partition p1 values less than ('fsds' ,110,2021),
partition p2 values less than ('MERN',116,2023)
);
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition6';

insert ignore into ineuron_partition6 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition6';

create table ineuron_partition7(
course_name varchar(50),
course_id int(10), 
course_title varchar(60),
course_desc varchar(60),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_lauch_year int)
partition by list columns(course_name)(
partition p0 values  in('aiops','data analytics','Dl','RL'),
partition p1 values  in('fsds' ,'big data','blockchain'),
partition p2 values  in('MERN','java','interview prep','fsda')
);

select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition7';

insert ignore into ineuron_partition7 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition7';

create table ineuron_partition8(
course_name varchar(50),
course_id int(10),
course_title varchar(60),
course_desc varchar(80),
launch_date date,
course_fee int,
course_mentor varchar(60),
course_launch_year int)
partition by range(course_launch_year)
subpartition by hash(course_launch_year)
subpartitions 5 (
partition p0 values less than (2019) ,
partition p1 values less than (2020) ,
partition p2 values less than (2021) ,
partition p3 values less than (2022) 
);
insert ignore into ineuron_partition8 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019);
select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_partition8';