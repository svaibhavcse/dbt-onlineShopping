{{
    config(
        tags = ['mart']
    )
}}

WITH customer AS (
    SELECT * FROM {{ ref('stg_customer')}}
),
market AS (
    SELECT * FROM {{ ref('stg_market')}}
),
orders As (
    select * from {{ ref('stg_order')}}
),
final AS (
    SELECT 
        cus.cust_id, 
        max(o.order_date) as most_recent_date,
        min(o.order_date) as first_ordered_date,
        sum((cast(m.sales as float)-cast(m.discount as float))*cast(m.order_quantity as int)) as lifetime_order_value,
        count(*) as total_orders
    FROM customer as cus
    join 
    market as m 
    on 
     cus.cust_id = m.cust_id
     join 
     orders as o 
     on 
     m.ord_id = o.ord_id
    where region != 'NUNAVUT'
    group by cus.cust_id
)

select * from final