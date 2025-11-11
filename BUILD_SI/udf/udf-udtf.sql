-- UDF and UDTF Example in Snowflake SQL
-- This script was created for workshops in relation to Snowflake's Season of Build 2025.

-- Set the role, database, and schema context
USE ROLE SNOWFLAKE_INTELLIGENCE_ADMIN;
USE DATABASE DASH_DB_SI;
USE SCHEMA RETAIL;

-- Display all existing functions
SHOW FUNCTIONS;

-- Create or replace a simple UDF that rounds a FLOAT to the nearest whole number using Python UDF
CREATE OR REPLACE FUNCTION RoundToWhole(value FLOAT)
    RETURNS NUMBER
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.13'
    HANDLER = 'round_value'
AS $$
def round_value(value):
    if value is None:
        return None
    return round(value, 0)
$$;

-- Show the created python UDF
SHOW FUNCTIONS LIKE 'RoundToWhole';

-- Display the Sales table
SELECT * FROM SALES;

-- Display the Sales table with rounded sales amounts using the RoundToWhole UDF
SELECT 
    DATE,
    REGION,
    PRODUCT_ID,
    UNITS_SOLD,
    RoundToWhole(SALES_AMOUNT) AS rounded_sales_amount
FROM SALES
ORDER BY 
    DATE,
    CASE WHEN UPPER(REGION) = 'NORTH' THEN 0 ELSE 1 END,
    REGION,
    PRODUCT_ID;

-- Create or replace a UDTF that calculates average price per unit of a product for each sale record using SQL UDTF
-- SQL UDTFs are generally more efficient
CREATE OR REPLACE FUNCTION AvgPricePerUnitProductPerSale()
    RETURNS TABLE (
        date DATE,
        region VARCHAR,
        product_id NUMBER,
        units_sold NUMBER,
        sales_amount NUMBER(38,2),
        avg_price_per_unit NUMBER(38,8)
    )
    LANGUAGE SQL
AS $$
    SELECT 
        DATE,
        REGION,
        PRODUCT_ID,
        UNITS_SOLD,
        SALES_AMOUNT,
        SALES_AMOUNT / UNITS_SOLD AS avg_price_per_unit
    FROM SALES
    WHERE UNITS_SOLD > 0
$$;

-- Show the created SQL UDTF
SHOW FUNCTIONS LIKE 'AvgPricePerUnitProductPerSale';

-- Call the UDTF to see average price per unit of a product for each sale record
SELECT * FROM TABLE(AvgPricePerUnitProductPerSale()) ORDER BY PRODUCT_ID, REGION;

-- Using the UDF and the UDTF, create a view with the average price per unit of a product for each sale record rounded to whole number
CREATE OR REPLACE VIEW avg_price_per_unit_product_per_sale AS
SELECT 
    PRODUCT_ID,
    REGION,
    RoundToWhole(avg_price_per_unit) AS rounded_avg_price_per_unit
FROM TABLE(AvgPricePerUnitProductPerSale());

-- Creates a new table PRODUCTS_WITH_AVG_PRICE that enriches the PRODUCTS table with the average of the rounded average prices from the avg_price_per_unit_product_per_sale view.
CREATE OR REPLACE TABLE PRODUCTS_WITH_AVG_PRICE AS
SELECT 
    p.*,
    ROUND(COALESCE(AVG(a.rounded_avg_price_per_unit), 2), 2) AS avg_price
FROM PRODUCTS p
LEFT JOIN avg_price_per_unit_product_per_sale a ON p.PRODUCT_ID = a.PRODUCT_ID
GROUP BY p.PRODUCT_ID, p.PRODUCT_NAME, p.CATEGORY;

-- Completion Message
SELECT 'UDF and UDTF creation and usage completed successfully!' AS status;