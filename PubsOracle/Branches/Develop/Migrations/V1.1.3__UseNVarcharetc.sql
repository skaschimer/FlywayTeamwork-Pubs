-- 'Dropping foreign keys from dbo.sales'
ALTER TABLE dbo.sales DROP CONSTRAINT FK__sales__stor_id;
ALTER TABLE dbo.sales DROP CONSTRAINT FK__sales__title_id;
-- 'Dropping constraints from dbo.sales'
ALTER TABLE dbo.sales DROP CONSTRAINT UPKCL_sales;
-- 'Dropping constraints from dbo.authors'
ALTER TABLE dbo.authors modify phone DEFAULT null; 
-- 'Dropping constraints from dbo.publishers'
ALTER TABLE dbo.publishers modify country DEFAULT null;
-- 'Dropping constraints from dbo.titles'
-- ALTER TABLE dbo.titles ALTER COLUMN "type" DROP DEFAULT;
-- 'Dropping index aunmind from dbo.authors'
DROP INDEX dbo.aunmindex;

-- 'Dropping index titleind from dbo.titles'
DROP INDEX dbo.titleindex;

-- 'Dropping index employee_ind from dbo.employee'
DROP INDEX dbo.employee_index;

-- 'Altering dbo.stores'
ALTER TABLE dbo.stores modify stor_name character varying(80);
ALTER TABLE dbo.stores modify stor_address character varying(80);
ALTER TABLE dbo.stores modify city  character varying(40);

-- 'Altering dbo.discounts'

ALTER TABLE dbo.discounts ADD
Discount_id NUMBER(5,0) GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE;

ALTER TABLE dbo.discounts modify discounttype character varying(80);


-- 'Creating primary key PK__discount__63D7679C0CEEA6FF on dbo.discounts'
ALTER TABLE dbo.discounts ADD PRIMARY KEY  (Discount_id);


ALTER TABLE dbo.employee  modify fname  character varying(40);
ALTER TABLE dbo.employee  modify  lname character varying(60);


-- 'Creating index employee_ind on dbo.employee'
CREATE INDEX employee_ind ON dbo.employee (lname, fname, minit);


ALTER TABLE dbo.publishers modify  pub_name  character varying(100);

ALTER TABLE dbo.publishers  modify  city character varying(100);

ALTER TABLE dbo.publishers  modify  country  character varying(80);

Drop View dbo.titleview;

-- 'Altering dbo.titles'

ALTER TABLE dbo.titles  modify  title VARCHAR2(255 CHAR);


ALTER TABLE dbo.titles  modify  type  character varying(80);


ALTER TABLE dbo.titles modify  notes character varying(4000);

-- 'Creating index titleind on dbo.titles'
CREATE INDEX titleindex ON dbo.titles (title);

-- 'Altering dbo.roysched'

ALTER TABLE dbo.roysched ADD
roysched_id NUMBER(5,0) GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1 INCREMENT BY 1 MINVALUE 1 NOMAXVALUE ;
ALTER TABLE dbo.roysched  ADD PRIMARY KEY  (roysched_id);



-- 'Altering dbo.sales'

ALTER TABLE dbo.sales modify ord_num character varying(80);
ALTER TABLE dbo.sales  modify  payterms character varying(40);
-- 'Creating primary key UPKCL_sales on dbo.sales'
ALTER TABLE dbo.sales ADD CONSTRAINT UPKCL_sales PRIMARY KEY (stor_id, ord_num, title_id);

ALTER TABLE dbo.authors modify au_lname character varying(80);
ALTER TABLE dbo.authors modify au_fname  character varying(80);
ALTER TABLE dbo.authors modify phone  character varying(40);
ALTER TABLE dbo.authors modify address character varying(80);
ALTER TABLE dbo.authors modify city  character varying(40);

-- 'Creating index aunmind on dbo.authors'
CREATE INDEX aunmindex ON dbo.authors (au_lname, au_fname);

-- 'Altering dbo.titleview'

CREATE OR REPLACE VIEW dbo.titleview
AS 
Select title, au_ord, au_lname, price, ytd_sales, pub_id
from dbo.titleauthor  inner join dbo.titles
on titles.title_id = titleauthor.title_id
inner join dbo.authors
on dbo.authors.au_id = dbo.titleauthor.au_id;



-- 'Altering dbo.byroyalty'
CREATE OR REPLACE PROCEDURE dbo.byroyalty
(
  v_percentage IN NUMBER
)
AS
   v_cursor SYS_REFCURSOR;

BEGIN

   OPEN  v_cursor FOR
      SELECT au_id 
        FROM titleauthor 
       WHERE  titleauthor.royaltyper = v_percentage ;
      DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/

CREATE OR REPLACE PROCEDURE dbo.reptq1
AS
   v_cursor SYS_REFCURSOR;

BEGIN

   OPEN  v_cursor FOR
      SELECT CASE 
                  WHEN GROUPING(pub_id)  = 1 THEN 'ALL'
             ELSE pub_id
                END pub_id  ,
             AVG(price)  avg_price  
        FROM titles 
       WHERE  price IS NOT NULL
        GROUP BY ROLLUP( pub_id )
        ORDER BY pub_id ;
      DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/
CREATE OR REPLACE PROCEDURE dbo.reptq2
AS
   v_cursor SYS_REFCURSOR;

BEGIN

   OPEN  v_cursor FOR
      SELECT CASE 
                  WHEN GROUPING(TYPE)  = 1 THEN 'ALL'
             ELSE TYPE
                END TYPE  ,
             CASE 
                  WHEN GROUPING(pub_id)  = 1 THEN 'ALL'
             ELSE pub_id
                END pub_id  ,
             AVG(ytd_sales)  avg_ytd_sales  
        FROM titles 
       WHERE  pub_id IS NOT NULL
        GROUP BY ROLLUP( pub_id,TYPE ) ;
      DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/
CREATE OR REPLACE PROCEDURE dbo.reptq3
(
  v_lolimit IN NUMBER,
  v_hilimit IN NUMBER,
  v_type IN CHAR
)
AS
   v_cursor SYS_REFCURSOR;

BEGIN

   OPEN  v_cursor FOR
      SELECT CASE 
                  WHEN GROUPING(pub_id)  = 1 THEN 'ALL'
             ELSE pub_id
                END pub_id  ,
             CASE 
                  WHEN GROUPING(TYPE)  = 1 THEN 'ALL'
             ELSE TYPE
                END TYPE  ,
             COUNT(title_id)  cnt  
        FROM titles 
       WHERE  price > v_lolimit
                AND price < v_hilimit
                AND TYPE = v_type
                OR TYPE LIKE '%cook%'
        GROUP BY ROLLUP( pub_id,TYPE ) ;
      DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/

-- 'Adding constraints to dbo.authors'
ALTER TABLE dbo.authors modify  phone CHAR(12) DEFAULT 'UNKNOWN';

-- 'Adding constraints to dbo.publishers'
ALTER TABLE dbo.publishers modify country VARCHAR2(30 CHAR) DEFAULT 'USA';

-- 'Adding constraints to dbo.titles'
ALTER TABLE dbo.titles modify type  character varying(80) DEFAULT ('UNDECIDED');

-- 'Adding foreign keys to dbo.sales'
-- 'Adding foreign keys to dbo.sales'
ALTER TABLE dbo.sales ADD CONSTRAINT FK_Sales_Stores FOREIGN KEY (stor_id) REFERENCES dbo.stores (stor_id);
ALTER TABLE dbo.sales ADD CONSTRAINT FK_Sales_Title FOREIGN KEY (title_id) REFERENCES dbo.titles (title_id);

