use sql_database;
CREATE TABLE if not exists sales_data (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL
);

SET SESSION sql_mode = '';

LOAD DATA INFILE 'C:/Data Analytics/MySql_sudhanshu/Data sets/sales_data_final.csv'
into table sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from sales_data;

select str_to_date(order_date,'%m/%d/%y') from sales_data;

alter table sales_data
add column order_date_new date after order_date;

update sales_data
set order_date_new = str_to_date(order_date,'%m/%d/%Y');

alter table sales_data
add column ship_date_new date after ship_date;

update sales_data
set ship_date_new = str_to_date(ship_date,'%m/%d/%Y');

select * from sales_data where ship_date_new='2011-01-05';
select * from sales_data where ship_date_new<'2011-01-05';
select * from sales_data where ship_date_new>'2011-01-05';
select * from sales_data where ship_date_new between '2011-01-01' and '2011-01-05';
select now();
select curdate();
select curtime();
select date_sub(now(), interval 1 week);

select * from sales_data where date_sub(now(), interval 1 week);
