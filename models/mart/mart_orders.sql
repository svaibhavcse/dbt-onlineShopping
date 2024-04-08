{{
    config(
        tags = ['mart']
    )
}}
 
WITH customer as (
    select * from {{ ref('stg_customer')}}
),
market as (
    select * from {{ ref('stg_market')}}
),
orders as (
    select * from {{ ref('stg_order')}}
),
order_data as (
    select c.customer_name ,o.order_id ,o.order_date,m.profit
    from customer c
     join
     market m
     on
      m.cust_id=c.cust_id  
     join
      orders o
     on 
     m.ord_id=o.ord_id
     where c.Region!='NUNAVUT'
     
)
select * from order_data
 
 