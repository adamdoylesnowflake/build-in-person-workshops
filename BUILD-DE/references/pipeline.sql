-- Select the account, warehouse, and database you are using
use role accountadmin;
use warehouse compute_wh;
use database analytics_db;

-- Displays all the dynamic tables that we have created
show dynamic tables;

-- Adjusting freshness
alter dynamic table stg_orders_dt set target_lag = '5 minutes';

-- Check for the altered dynamic table's new target_lag
show dynamic tables;

-- Monitoring pipeline health
select * from table(information_schema.dynamic_table_refresh_history());

-- Query the Fact DT and check for potential issues
select * from analytics_db.public.fct_customer_orders_dt;

-- Integrated data quality to remove null orders
create or replace dynamic table fct_customer_orders_dt
    target_lag=downstream
    warehouse=compute_wh
    as select 
        c.customer_id,
        c.customer_name,
        o.product_id,
        o.order_price,
        o.quantity,
        o.order_date
    from stg_customers_dt c
    left join stg_orders_dt o
        on c.customer_id = o.customer_id
    where o.product_id is not null;

-- Check if the data quality enforcement works
select * from analytics_db.public.fct_customer_orders_dt;