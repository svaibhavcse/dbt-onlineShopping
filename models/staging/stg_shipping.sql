{{
    config(
        tags = ['staging']
    )
}}

WITH shipping AS (
    SELECT * FROM {{ source('shopping','shipping')}}
),
renaming_and_convertion AS (
    SELECT 
    [Order_ID]
      ,[Ship_Mode]
      ,CONVERT(date,Ship_Date,105) AS Ship_Date
      ,[Ship_id]
      FROM shipping
)
SELECT * FROM renaming_and_convertion