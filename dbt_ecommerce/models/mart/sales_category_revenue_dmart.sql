{{ config(
  tags = ['sales_category_revenue_dmart']
) }}

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
  SUM(so.quantity) AS total_quantity
FROM
  products_list AS p
  LEFT JOIN {{ ref('stg_ecommerce_db_orders') }} AS so
  ON p.product_id = so.product_id
  LEFT JOIN(
    SELECT
      o.order_id AS A,
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
  ON so.order_id = ro.a
WHERE
  ro.return_status = 'Not Return'
GROUP BY
  1,
  2
ORDER BY
  1,
  2 ASC
