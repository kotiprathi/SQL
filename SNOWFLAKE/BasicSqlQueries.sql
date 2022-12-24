show databases;
use database sql_database;
CREATE OR REPLACE table PK_CONSUMER_COMPLIANTS(
     DATE_RECEIVED STRING,
     PRODUCT_NAME VARCHAR2(50),
     SUB_PRODUCT VARCHAR2(100),
     ISSUE VARCHAR2(100),
     SUB_ISSUE VARCHAR2(100),
     CONSUMER_COMPLAINT_NARRATIVE string,
     Company_Public_Response STRING,
     Company VARCHAR(100),
     State_Name CHAR(40),
     Zip_Code string,
     Tags VARCHAR(40),
     Consumer_Consent_Provided CHAR(25),
     Submitted_via STRING,
     Date_Sent_to_Company STRING,
     Company_Response_to_Consumer VARCHAR(40),
     Timely_Response CHAR(40),
     CONSUMER_DISPUTED CHAR(40),
     COMPLAINT_ID NUMBER(12,0) NOT NULL PRIMARY KEY
);

select * from PK_CONSUMER_COMPLIANTS;
select distinct * from PK_CONSUMER_COMPLIANTS;
select distinct PRODUCT_NAME from PK_CONSUMER_COMPLIANTS;
select distinct COMPANY from PK_CONSUMER_COMPLIANTS;
DESCRIBE TABLE PK_CONSUMER_COMPLIANTS;

-- LIKE KEYWORD
/* -- comment starting

% represents zero,one,or multiple characters
_ underscore represnts one,singe chracter

a% - any values that starts with a
%a - any values that ends with a
%word% - any values that has word in any position

_a% - any values that has a in the second position
a_% - any values that starts with "a" and are atleast 2 chracters in length
a__% - any values that starts with "a" and are atleast 3 chracters in length
a%r - any values that starts with a and ends with r

ab%cd%de%f - any values that starts with ab followed by any characters and then cd and then followed by any characters 
and then de followed by any charcaters and ending with f

*/

--  a% - any values that starts with a
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME LIKE 'Bank%';      -- Bank at the start followed by any characters

-- %word% - any values that has word in any position
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME LIKE '%account%';  -- account can come at anywhere in the word
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME LIKE '%Credit%';   -- credit can come at anywhere in the word

-- %a - any values that ends with a
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME LIKE '%account';   -- any sequence of characters followed by account at the end
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME LIKE '%Loan';      -- any sequence of character followed by loan at the end 

-- _a% - any values that has a in the second position
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE COMPANY LIKE '_a%';

-- a_% - any values that starts with "a" and are atleast 2 chracters in length
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE COMPANY LIKE 'F_%';

-- a__% - any values that starts with "a" and are atleast 3 chracters in length
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE SUBMITTED_VIA LIKE 'F__%';

-- a%r - any values that starts with a and ends with r
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE SUB_PRODUCT LIKE 'C%t';
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE ISSUE LIKE 'M%e';


-------------------------------IN KEYWORD---------------------------------------------------------------------
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE PRODUCT_NAME IN ('Consumer Loan','Mortgage','Student loan');

------------------------------BETWEEN KEYWORD-----------------------------------------------------------------
SELECT DISTINCT * FROM PK_CONSUMER_COMPLIANTS WHERE TO_DATE(DATE_RECEIVED,'DD-MM-YYYY') BETWEEN TO_DATE('29-07-2013','DD-MM-YYYY') AND TO_DATE('31-07-2013','DD-MM-YYYY');

SELECT TO_DATE(DATE_RECEIVED,'DD-MM-YYYY') FROM PK_CONSUMER_COMPLIANTS;

------------------------------CASE KEYWORD-------------------------------------------------------------------
SELECT DISTINCT SUBMITTED_VIA FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT *, 
  CASE
    WHEN SUBMITTED_VIA IN('Phone','Web') THEN 'INBOUND'
    WHEN SUBMITTED_VIA IN('Referral','Postal mail','Email') THEN 'OUTBOUND'
    ELSE 'Electronics'
  END AS SUBMITTED_MODE 
FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT PRODUCT_NAME FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT *,
  CASE 
       --WHEN PRODUCT_NAME LIKE '%Loan%' or PRODUCT_NAME LIKE '%loan%' THEN 'LOAN'
       WHEN UPPER(PRODUCT_NAME) LIKE '%LOAN%' THEN 'Loan'   -- OPTIMIZED CODE
       WHEN PRODUCT_NAME IN('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers','Prepaid card') THEN 'SERVICE'
       ELSE 'OTHER'
  END AS FINANCIAL_TYPE
FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT SUB_PRODUCT FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT *,
  CASE WHEN UPPER(SUB_PRODUCT) LIKE '%LOAN%' then 'LOAN'
       WHEN UPPER(SUB_PRODUCT) LIKE '%CARD%' then 'CARD'
       WHEN UPPER(SUB_PRODUCT) LIKE '%MORTGAGE' THEN 'MORTGAGE'
       WHEN SUB_PRODUCT='I do not know' OR SUB_PRODUCT IS NULL THEN 'NA'
       ELSE SUB_PRODUCT
  END AS SUB_PRODUCT_TYPE
FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT COMPANY_RESPONSE_TO_CONSUMER FROM PK_CONSUMER_COMPLIANTS;

SELECT DISTINCT *,
  CASE 
      WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('CLOSED','Closed with non-monetary relief') THEN 'CLOSED'
      WHEN UPPER(COMPANY_RESPONSE_TO_CONSUMER) LIKE '%EXPLANATION%' THEN 'EXPLANATION'
      WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with monetary relief') THEN 'MONETARY RELIEF PROVIDED'
      ELSE COMPANY_RESPONSE_TO_CONSUMER
  END AS COMPANY_RESPONSE_TO_CONSUMER_TYPE
FROM PK_CONSUMER_COMPLIANTS;

---------------CREATING VIEW TABLE FROM ALL THE ABOVE CASES--------------------

CREATE OR REPLACE VIEW PK_CONSUMER_COMPLIANTS_TO_CUSTOMER AS
SELECT DISTINCT DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,STATE_NAME,SUBMITTED_VIA,COMPANY_RESPONSE_TO_CONSUMER,
  CASE
      WHEN SUBMITTED_VIA IN('Phone','Web') THEN 'INBOUND'
      WHEN SUBMITTED_VIA IN('Referral','Postal mail','Email') THEN 'OUTBOUND'
      ELSE 'Electronics'
  END AS SUBMITTED_MODE,
  
  CASE 
       --WHEN PRODUCT_NAME LIKE '%Loan%' or PRODUCT_NAME LIKE '%loan%' THEN 'LOAN'
       WHEN UPPER(PRODUCT_NAME) LIKE '%LOAN%' THEN 'Loan'   -- OPTIMIZED CODE
       WHEN PRODUCT_NAME IN('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers','Prepaid card') THEN 'SERVICE'
       ELSE 'OTHER'
  END AS FINANCIAL_TYPE,
  
  CASE WHEN UPPER(SUB_PRODUCT) LIKE '%LOAN%' then 'LOAN'
       WHEN UPPER(SUB_PRODUCT) LIKE '%CARD%' then 'CARD'
       WHEN UPPER(SUB_PRODUCT) LIKE '%MORTGAGE' THEN 'MORTGAGE'
       WHEN SUB_PRODUCT='I do not know' OR SUB_PRODUCT IS NULL THEN 'NA'
       ELSE SUB_PRODUCT
  END AS SUB_PRODUCT_TYPE,
  
  CASE 
      WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('CLOSED','Closed with non-monetary relief') THEN 'CLOSED'
      WHEN UPPER(COMPANY_RESPONSE_TO_CONSUMER) LIKE '%EXPLANATION%' THEN 'EXPLANATION'
      WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with monetary relief') THEN 'MONETARY RELIEF PROVIDED'
      ELSE COMPANY_RESPONSE_TO_CONSUMER
  END AS COMPANY_RESPONSE_TO_CONSUMER_TYPE
FROM PK_CONSUMER_COMPLIANTS;

SELECT * FROM PK_CONSUMER_COMPLIANTS_TO_CUSTOMER;

-------------------------------------------------------------------
select * from PK_CONSUMER_COMPLIANTS;

create or replace view pk_consumer_compliant_view as
select *,concat(STATE_NAME,ZIP_CODE) as STATE_DETAILS from PK_CONSUMER_COMPLIANTS
where PRODUCT_NAME is not null AND SUB_PRODUCT is not null AND COMPANY is not null
AND ISSUE is not null AND SUB_ISSUE is not null AND CONSUMER_COMPLAINT_NARRATIVE is not null AND 
COMPANY_PUBLIC_RESPONSE is not null AND TAGS is not null;

select * from pk_consumer_compliant_view;
