with products as (
  select * from {{ source('ecommerce_db','products')}}
)
select * from products