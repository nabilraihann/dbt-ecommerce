with customers as (
  select * from {{ source('ecommerce_db','customers')}}
)
select * from customers