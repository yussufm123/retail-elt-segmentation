-- data first 5 rows
SELECT
	*
FROM
	retail_orders
LIMIT 5;

-- change column names to lowercase with underscore
ALTER TABLE retail_orders RENAME COLUMN "InvoiceNo" TO "invoice_no";
ALTER TABLE retail_orders RENAME COLUMN "StockCode" TO "stock_code";
ALTER TABLE retail_orders RENAME COLUMN "Description" TO "description";
ALTER TABLE retail_orders RENAME COLUMN "Quantity" TO "quantity";
ALTER TABLE retail_orders RENAME COLUMN "InvoiceDate" TO "invoice_date";
ALTER TABLE retail_orders RENAME COLUMN "UnitPrice" TO "unit_price";
ALTER TABLE retail_orders RENAME COLUMN "CustomerID" TO "customer_id";
ALTER TABLE retail_orders RENAME COLUMN "Country" TO "country";

-- verify data types
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'retail_orders'
ORDER BY ordinal_position;

-- correct data types
ALTER TABLE retail_orders
	ALTER COLUMN invoice_no TYPE VARCHAR(200),
  	ALTER COLUMN stock_code TYPE VARCHAR(200),
	ALTER COLUMN quantity TYPE integer,
	ALTER COLUMN unit_price TYPE numeric(10, 2) USING unit_price::numeric(10, 2),
    ALTER COLUMN invoice_date TYPE timestamp USING invoice_date::timestamp,
    ALTER COLUMN customer_id TYPE integer USING customer_id::integer;

-- checking null values
SELECT
	count(*)
FROM
	retail_orders
WHERE
	customer_id IS NULL;

-- drop customer ID null values
DELETE FROM retail_orders
WHERE customer_id IS NULL;

-- inspect cancelled orders (invoice_no starting with 'C')
SELECT count(*) 
FROM retail_orders 
WHERE invoice_no LIKE 'C%';

-- drop cancellations
DELETE FROM retail_orders 
WHERE invoice_no LIKE 'C%';

-- inspect negative or zero quantity
SELECT count(*) 
FROM retail_orders 
WHERE quantity <= 0;

-- inspect zero or negative unit_price
SELECT count(*) 
FROM retail_orders 
WHERE unit_price <= 0;

-- drop negative or zero unit_price
DELETE FROM retail_orders
WHERE unit_price <= 0;


-- create new colum for total price
ALTER TABLE retail_orders ADD COLUMN total_price numeric(12, 2);

UPDATE retail_orders
SET total_price = quantity * unit_price;

-- checking exact duplicate rows
SELECT COUNT(*) FROM (SELECT invoice_no, stock_code, customer_id, quantity, invoice_date, count(*)
FROM retail_orders
GROUP BY invoice_no, stock_code, customer_id, quantity, invoice_date
HAVING count(*) > 1)
WHERE count > 1;

SELECT SUM(cnt - 1) AS excess_rows_to_remove
FROM (
    SELECT count(*) AS cnt
    FROM retail_orders
    GROUP BY invoice_no, stock_code, customer_id, quantity, invoice_date
    HAVING count(*) > 1
);

-- drop duplicate rows
DELETE FROM retail_orders
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY invoice_no, stock_code, customer_id, quantity, invoice_date
                   ORDER BY ctid
               ) AS rn
        FROM retail_orders
    )
    WHERE rn > 1
);

-- remaining rows
SELECT count(*) AS remaining_rows FROM retail_orders;

