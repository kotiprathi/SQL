"MY_DATABASE""MY_DATABASE"use warehouse sql_warehouse;
use database sql_database;

show databases;

CREATE OR REPLACE TABLE OWNER
(
   OwnerID INTEGER NOT NULL PRIMARY KEY ,
   Name VARCHAR2(20),
   Surname STRING,
   StreetAddress VARCHAR2(50),
   City STRING,
   State CHAR(4),
   StateFull STRING,
   ZipCode INTEGER
);

CREATE OR REPLACE TABLE PETS
(
    PetID VARCHAR(10) NOT NULL PRIMARY KEY,
    Name VARCHAR(20),
    Kind STRING,
    Gender CHAR(7),
    Age INTEGER,
    OwnerID INTEGER NOT NULL REFERENCES OWNER 
);

SELECT * FROM OWNER; -- 89 ROWS
SELECT * FROM PETS;-- 100 ROWS

--Inner Join
select owner.ownerid,owner.name,pets.name
from owner inner join pets on owner.ownerid = pets.ownerid;

-- master table
create or replace table PK_OWNER_PETS as 
select owner.ownerid,owner.name as own_name,pets.name as pet_name
from owner inner join pets on owner.ownerid = pets.ownerid;

select * from PK_OWNER_PETS;

----Left outer join
select pets.name as pet_name,owner.ownerid,owner.name as own_name
from pets left outer join owner on owner.ownerid = pets.ownerid;


-- Assignement
-- load complain administration data 

CREATE OR REPLACE TABLE PK_BROKER
(
  BrokerID	INT,
  BrokerCode VARCHAR(70),
  BrokerFullName	VARCHAR(60),
  DistributionNetwork	VARCHAR(60),
  DistributionChannel	VARCHAR(60),
  CommissionScheme VARCHAR(50)
);
select distinct * from PK_BROKER; --708 ROWS
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_CATAGORIES
(
ID	INT,
Description_Categories VARCHAR2(200),
Active INT
);

select * from PK_CATAGORIES; --56 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_COMPLAINS_DATA
(
 ID	INT ,
 ComplainDate VARCHAR(10),
 CompletionDate	VARCHAR(10),
 CustomerID	INT,
 BrokerID	INT,
 ProductID	INT,
 ComplainPriorityID	INT,
 ComplainTypeID	INT,
 ComplainSourceID	INT,
 ComplainCategoryID	INT,
 ComplainStatusID	INT,
 AdministratorID	STRING,
 ClientSatisfaction	VARCHAR(20),
 ExpectedReimbursement INT
);

select * from PK_COMPLAINS_DATA; -- 13846 ROWS
---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TABLE PK_CUSTOMER
(
CustomerID	INT,
LastName VARCHAR(60),
FirstName VARCHAR(60),
BirthDate VARCHAR(20) ,
Gender VARCHAR(20),
ParticipantType	VARCHAR(20),
RegionID	INT,
MaritalStatus VARCHAR(15));

select distinct * from PK_customer;--12,305
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_PRIORITIES
(
ID	INT,
Description_Priorities VARCHAR(10)
);

select DISTINCT * from PK_PRIORITIES; --2 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_PRODUCT
(
ProductID	INT,
ProductCategory	VARCHAR(60),
ProductSubCategory	VARCHAR(60),
Product VARCHAR(30)
);

select distinct * from PK_PRODUCT; -- 77rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_REGION
(
  id INT,
  name	VARCHAR(50) ,
  county	VARCHAR(100),
  state_code	CHAR(5),
  state	VARCHAR (60),
  type	VARCHAR(50),
  latitude	NUMBER(11,4),
  longitude	NUMBER(11,4),
  area_code	INT,
  population	INT,
  Households	INT,
  median_income	INT,
  land_area	INT,
  water_area	INT,
  time_zone VARCHAR(70)
);

SELECT DISTINCT * FROM PK_REGION; -- 994 ROWS
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_SOURCES
(
ID	INT,
Description_Source VARCHAR(20)
);

select distinct * from PK_SOURCES; -- 9 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_STATE_REGION
(
  State_Code VARCHAR(20),	
  State	 VARCHAR(50),
  Region VARCHAR(50)
);

select DISTINCT * from PK_STATE_REGION; --48 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_STATUS_HISTORY
(
   ID INT,
   ComplaintID	INT not null,
   ComplaintStatusID INT,
   StatusDate VARCHAR(10)
);

select * from PK_STATUS_HISTORY; --11,558
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_STATUSES
(
  ID	INT,
  Description_Status VARCHAR(40));
  
  select DISTINCT * from PK_STATUSES; -- 7 rows
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE PK_TYPE
(
  ID INT,
  Description_Type VARCHAR(20)
);

select DISTINCT * from PK_type; -- 10 rows
----------------------------------------------------------------------------------------------------------

-- we have to join the tables based on number of records.
-- the table which has highest records should be taken as left table and when we are joining multiple tables also we have join the tables based on count of records.

create or replace table PK_Complains_master_table as
SELECT COM.ID,COM.ComplainDate,COM.CompletionDate,CUS.LastName,CUS.FirstName,
CUS.Gender,BR.BrokerFullName,BR.CommissionScheme,
CAT.Description_Categories,SR.Region,ST.Description_Status,RE.state,PR.Product,
PRI.Description_Priorities,SOR.Description_Source,TY.Description_Type
-- COM.*, CUS.*, SH.*, BR.*, RE.*, PR.*, CAT.*, SR.*, TY.*, SOR.*, ST.*, PRI.*
FROM PK_COMPLAINS_DATA COM
LEFT OUTER JOIN PK_CUSTOMER CUS ON COM.CustomerID = CUS.CustomerID
LEFT OUTER JOIN PK_STATUS_HISTORY SH ON COM.ID = SH.ID
LEFT OUTER JOIN PK_REGION RE ON CUS.REGIONID = RE.ID
LEFT OUTER JOIN PK_BROKER BR ON COM.BROKERID = BR.BROKERID
LEFT OUTER JOIN PK_PRODUCT PR ON COM.ProductID = PR.ProductID
LEFT OUTER JOIN PK_CATAGORIES CAT ON COM.COMPLAINCATEGORYID = CAT.ID
LEFT OUTER JOIN PK_STATE_REGION SR ON RE.STATE_CODE = SR.STATE_CODE
LEFT OUTER JOIN PK_TYPE TY ON COM.ComplainTypeID = TY.ID
LEFT OUTER JOIN PK_SOURCES SOR ON  COM.ComplainSourceID = SOR.ID
LEFT OUTER JOIN PK_STATUSES ST ON COM.ComplainStatusID = ST.ID
LEFT OUTER JOIN PK_PRIORITIES PRI ON COM.ComplainPriorityID = PRI.ID
;

select * from PK_Complains_master_table;
select * from PK_Complains_master_table where completiondate='NULL';
