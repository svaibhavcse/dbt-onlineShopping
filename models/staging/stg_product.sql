{{
    config(
        tags = ['staging']
    )
}}

WITH product AS (
    SELECT * 
    FROM 
    {{ source('shopping','product')}}
)
SELECT * FROM product