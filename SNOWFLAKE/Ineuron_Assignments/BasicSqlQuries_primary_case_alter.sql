use database SQL_DATABASE;

-------------------------------------------ASSIGNMENT---------------------------------------------

---1st--- created the table PK_FINAL_SALES and loaded the data into table
CREATE OR REPLACE TABLE PK_FINAL_SALES(
order_id VARCHAR2(20),
order_date VARCHAR2(20) PRIMARY KEY,
ship_date VARCHAR2(20),
ship_mode VARCHAR2(40),	
customer_name varchar2(50),	
segment	VARCHAR2(40),
state VARCHAR2(40),
country	VARCHAR(40),
market STRING,
region VARCHAR2(40),
product_id STRING,
category VARCHAR2(40),
sub_category VARCHAR2(40),
product_name varchar2(170),
sales NUMBER(10,0),
quantity NUMBER(10,0),
discount NUMBER(10,4),
profit INT,
shipping_cost NUMBER(10,4),	
order_priority VARCHAR2(20),
year VARCHAR2(10)
);
DESCRIBE TABLE PK_FINAL_SALES;
select * from PK_FINAL_SALES;

CREATE OR REPLACE TABLE PK_FINAL_SALES_COPY AS
SELECT * FROM PK_FINAL_SALES;
DESCRIBE TABLE PK_FINAL_SALES_COPY;

---2nd---change the primaty key to order_id column
ALTER TABLE PK_FINAL_SALES_COPY
DROP PRIMARY KEY;
ALTER TABLE PK_FINAL_SALES_COPY
ADD PRIMARY KEY(ORDER_ID);
DESCRIBE TABLE PK_FINAL_SALES_COPY;

---3rd--- changed the order_date and ship_date data type from VARCHAR to Date datatype
UPDATE PK_FINAL_SALES_COPY
set ORDER_DATE = to_date(order_date);
SELECT * FROM PK_FINAL_SALES_COPY;

UPDATE PK_FINAL_SALES_COPY
set SHIP_DATE = to_date(SHIP_DATE);
SELECT * FROM PK_FINAL_SALES_COPY;

---4th--- extract the number after the last '-' from order_id column and add it to order_extract
ALTER TABLE PK_FINAL_SALES_COPY
ADD COLUMN ORDER_EXTRACT NUMBER(10,0);

UPDATE PK_FINAL_SALES_COPY
SET ORDER_EXTRACT = SUBSTRING(ORDER_ID,9);
SELECT * FROM PK_FINAL_SALES_COPY;

---5th--- create a new column called discount_flag and update it based on discount value
select * from pk_final_sales_copy;

ALTER TABLE PK_FINAL_SALES_COPY
ADD DISCOUNT_FLAG VARCHAR(10) AS
(CASE 
        WHEN DISCOUNT > 0 THEN 'YES'
        ELSE 'NO'
END);

---6th--- 
ALTER TABLE PK_FINAL_SALES_COPY
ADD COLUMN PROCESS_DAYS NUMBER(5,0);

UPDATE PK_FINAL_SALES_COPY
SET PROCESS_DAYS = DATEDIFF('DAY',ORDER_DATE,SHIP_DATE);
SELECT * FROM PK_FINAL_SALES_COPY;

---7th--- create a new column rating and then based on the process_days give the rating
ALTER TABLE PK_FINAL_SALES_COPY
ADD COLUMN RATING NUMBER(2,0) AS 
(CASE 
        WHEN PROCESS_DAYS <= 3 AND PROCESS_DAYS > 0 THEN 5
        WHEN PROCESS_DAYS >3 AND PROCESS_DAYS <= 6 THEN 4
        WHEN PROCESS_DAYS > 6 AND PROCESS_DAYS <= 10 THEN 3
        ELSE 2
END);
SELECT * FROM PK_FINAL_SALES_COPY;
