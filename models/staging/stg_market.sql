{{
    config(
        tags = ['staging']
    )
}}

WITH market AS (
    SELECT
    *
    FROM 
    {{source('shopping','market')}}
),
renaming_and_convertion AS (

    SELECT
    [Ord_id]
      ,[Prod_id]
      ,[Ship_id]
      ,[Cust_id]    
      ,CAST(Sales AS Decimal) AS Sales
      ,CAST(Discount AS Decimal) As Discount
      ,CAST(Order_Quantity AS NUMERIC) AS Order_Quantity
      ,CAST(Profit AS Decimal) AS Profit
      ,CAST(Shipping_Cost AS Decimal ) AS Shipping_Cost
      ,CAST(Product_Base_Margin AS Decimal) AS Product_Base_Margin
    FROM 
    market
)

SELECT * FROM market;