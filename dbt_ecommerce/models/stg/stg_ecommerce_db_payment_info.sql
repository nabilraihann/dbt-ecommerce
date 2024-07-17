with payment_info as (
  select * from {{ source('ecommerce_db','payment_info')}}
)
select * from payment_info