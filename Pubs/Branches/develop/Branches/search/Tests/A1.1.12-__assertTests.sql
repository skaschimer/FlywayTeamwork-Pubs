/* Assert */
/* Compare with OrdersPerTitlePerCompany */
-- The number OF orders for each title FROM each company
SELECT Sum(qty) AS Quantity, Title, Coalesce(stor_name, 'Direct Order') AS Bookshop
  FROM
  dbo.sales
    INNER JOIN dbo.publications
      ON publications.Publication_id = sales.title_id
    INNER JOIN dbo.stores
      ON stores.stor_id = sales.stor_id
GROUP BY Title, Stor_name;

/* Compare with OrdersPerTitleAndBuyers */
-- The number OF orders of each title, and a list of who bought them FROM each company
SELECT Sum(qty) AS Quantity, title, String_Agg(stor_name,', ')AS Bookshops
  FROM
  dbo.sales
    INNER JOIN dbo.publications
      ON publications.Publication_id = sales.title_id
    INNER JOIN dbo.stores
      ON stores.stor_id = sales.stor_id
GROUP BY Title;

/* Compare with PricePerType */
-- This query calculates the average price of books by type using a window function.
SELECT title_id, title, price,
       AVG(price) OVER (PARTITION BY type) AS avg_price_by_type
FROM titles;
 
/* Compare with BookByPrice */
--This query calculates the rank of each book based on its price using a window function. 
SELECT title_id, title, price,
       RANK() OVER (ORDER BY price DESC) AS price_rank
FROM titles;
