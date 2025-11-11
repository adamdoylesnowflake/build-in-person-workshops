-- Select the account, warehouse, and database you are using
use role accountadmin;
use warehouse compute_wh;
use database analytics_db;

-- Check the values in each DT
select * from analytics_db.public.stg_customers_dt;
select * from analytics_db.public.stg_orders_dt;

-- Create a fact dynamic table for customer orders
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
        on c.customer_id = o.customer_id;

-- Query the new Fact DT that you created
select * from analytics_db.public.fct_customer_orders_dt;