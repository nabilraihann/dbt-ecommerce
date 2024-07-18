{{ config(
  tags = ['sales_order_dmart']
) }}

WITH return_orders AS (

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
)
SELECT
  ord.order_id,
  ord.order_date,
  sup.seller_name,
  pr.product_name,
  CONCAT(cust.first_name,' ',cust.last_name) AS customer_name,
  ord.status,
  ord.quantity,
  ord.unit_price,
  ord.total_price,
  pym.card_number,
  rs.return_status
FROM
  {{ ref('stg_ecommerce_db_orders') }} AS ord
  LEFT JOIN return_orders rs
  ON ord.order_id = rs.a
  LEFT JOIN {{ ref('stg_ecommerce_db_products') }} AS pr
  ON ord.product_id = pr.product_id
  LEFT JOIN {{ ref('stg_ecommerce_db_customers') }} AS cust
  ON ord.customer_id = cust.customer_id
  LEFT JOIN {{ ref('stg_ecommerce_db_suppliers') }} AS sup
  ON ord.product_id = sup.product_id
  LEFT JOIN {{ ref('stg_ecommerce_db_payment_info') }} AS pym
  ON ord.order_id = pym.order_id
