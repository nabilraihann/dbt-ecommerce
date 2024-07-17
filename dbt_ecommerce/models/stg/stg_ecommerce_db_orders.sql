with orders as (
  select * from {{ source('ecommerce_db','orders')}}
)
select * from orders