{{
  config(
    tags=['sales_category_revenue_dmart']
  )
}}

WITH products_list AS (
  SELECT
    product_id,
    product_name,
    category
  FROM
    {{ ref('stg_ecommerce_db_products') }}
)
SELECT
  p.category,
  p.product_name,
  ROUND(SUM(so.total_price)) AS total_sales,
  SUM(so.quantity) as total_quantity
FROM
  products_list as  p
  LEFT JOIN {{ ref('stg_ecommerce_db_orders') }} AS so ON p.product_id = so.product_id
  LEFT JOIN(
    SELECT 
o.order_id AS a,
r.order_id AS b,
CASE 
	when r.order_id != 0 then 'Return'
	ELSE 'Not Return'
END as return_status
from {{ ref('stg_ecommerce_db_orders') }} AS o 
left join {{ ref('stg_ecommerce_db_returns') }} AS r on o.order_id = r.order_id 
  ) as ro on so.order_id = ro.a
  where ro.return_status = 'Not Return'
GROUP BY
  1,
  2
ORDER BY
  1,
  2 ASC
