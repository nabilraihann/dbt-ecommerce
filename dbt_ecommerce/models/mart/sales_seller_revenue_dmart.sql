{{
  config(
    tags=['sales_seller_revenue_dmart']
  )
}}

with suppliers_products as (
SELECT
s.seller_id ,
s.seller_name ,
p.product_id as product_id ,
p.category ,
p.product_name ,
FROM {{ref('stg_ecommerce_db_suppliers')}} as s
left join {{ref('stg_ecommerce_db_products')}} as p on s.product_id = p.product_id 
)
SELECT 
sp.seller_name,
sp.category,
sp.product_name,
round(sum(o.total_price)) as total_sales,
sum(o.quantity) as total_quantity
from suppliers_products as sp
left join {{ref('stg_ecommerce_db_orders')}} as o on sp.product_id = o.product_id 
LEFT join (
SELECT 
o.order_id AS a,
r.order_id AS b,
CASE 
	when r.order_id != 0 then 'Return'
	ELSE 'Not Return'
END as return_status
from {{ref('stg_ecommerce_db_orders')}} AS o 
left join {{ref('stg_ecommerce_db_returns')}} AS r on o.order_id = r.order_id 
) as ro on o.order_id = ro.a
GROUP BY 1,2,3
ORDER by 1,2,3