{{
    config(
        tags = ['staging']
    )
}}

WITH orders AS (
    SELECT
    *
    FROM 
    {{source('shopping','order')}}
),
renaming_and_convertion AS (

    SELECT
    order_id,
    CONVERT( date,Order_Date,105) as Order_Date,
    Order_Priority,
    Ord_id
    FROM 
    orders
)

SELECT * FROM renaming_and_convertion;