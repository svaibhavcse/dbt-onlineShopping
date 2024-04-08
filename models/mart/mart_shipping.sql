
{{
    config(
        tags = ['mart']
    )
}}
 
WITH
stg_shippings AS (
    SELECT *
    FROM {{ ref('stg_shipping') }}
),
stg_orders AS (
    SELECT *
    FROM {{ ref('stg_order') }}
),
stg_customers AS (
    SELECT *
    FROM {{ ref('stg_customer') }}
),
stg_markets AS (
    SELECT *
    FROM {{ ref('stg_market') }}
),
get_delayed AS (
    SELECT
        ss.*,
        so.order_date,
        so.order_priority,
        so.ord_id,
        DATEDIFF(day, CONVERT(DATE, so.order_date, 105), CONVERT(DATE, ss.ship_date, 105)) AS Delayed_In_Days
    FROM stg_shippings ss
    LEFT JOIN stg_orders so ON ss.order_id = so.order_id
),
customer_markets AS (
    SELECT
        sc.region,
        sc.customer_segment,
        sm.*
    FROM stg_customers sc
    JOIN stg_markets sm ON sc.cust_id = sm.cust_id
    WHERE sc.Region != 'NUNAVUT'
),
final AS (
    SELECT 
        cm.region,
        cm.prod_id,
        cm.cust_id,
        cm.order_Quantity,
        cm.shipping_Cost,
        gd.*,
        CASE 
            WHEN so.order_priority = 'CRITICAL' AND gd.Delayed_In_Days > 3 THEN 'True'
            ELSE 'False'
        END AS support
    FROM customer_markets cm
    JOIN get_delayed gd ON cm.ship_id = gd.ship_id
    LEFT JOIN stg_orders so ON gd.ord_id = so.ord_id
)

SELECT * FROM final;
