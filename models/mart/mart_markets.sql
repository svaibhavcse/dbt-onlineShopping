{{
    config(
        tags = ['mart']
    )
}}

WITH market as (
    select * from {{ ref('stg_market')}}
),
product as (
    select * from {{ ref('stg_product')}}
),
customer as (
    select * from {{ ref('stg_customer')}}
),
final as (
    select 
    m.*,
    p.product_category,
    p.product_sub_category
    from market as m 
    join 
    product as p 
    on 
    p.prod_id = m.prod_id
    join 
    customer as cus
    on cus.cust_id = m.cust_id
    where cus.region != 'NUNAVUT'
)
select * from final