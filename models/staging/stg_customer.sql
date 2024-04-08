{{
    config(
        tags = ['staging']
    )
}}
 WITH customer AS (
    SELECT 
    * 
    FROM 
    {{source('shopping','customer') }}
 )
 SELECT * FROM customer