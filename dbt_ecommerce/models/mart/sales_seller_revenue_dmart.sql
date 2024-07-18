{{ config(
  tags = ['sales_seller_revenue_dmart']
) }}

WITH suppliers_products AS (

  SELECT
    s.seller_id,
    s.seller_name,
    p.product_id AS product_id,
    p.category,
    p.product_name,
  FROM
    {{ ref('stg_ecommerce_db_suppliers') }} AS s
    LEFT JOIN {{ ref('stg_ecommerce_db_products') }} AS p
    ON s.product_id = p.product_id
)
SELECT
  sp.seller_name,
  sp.category,
  sp.product_name,
  ROUND(SUM(o.total_price)) AS total_sales,
  SUM(o.quantity) AS total_quantity
FROM
  suppliers_products AS sp
  LEFT JOIN {{ ref('stg_ecommerce_db_orders') }} AS o
  ON sp.product_id = o.product_id
  LEFT JOIN (
    SELECT
      o.order_id AS a,
      r.order_id AS b,
      CASE
        WHEN r.order_id != 0 THEN 'Return'
        ELSE 'Not Return'
      END AS return_status
    FROM
      {{ ref('stg_ecommerce_db_orders') }} AS o
      LEFT JOIN {{ ref('stg_ecommerce_db_returns') }} AS r
      ON o.order_id = r.order_id
  ) AS ro
  ON o.order_id = ro.a
GROUP BY
  1,
  2,
  3
ORDER BY
  1,
  2,
  3
