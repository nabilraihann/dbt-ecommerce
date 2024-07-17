with returns as (
  select * from {{ source('ecommerce_db','returns')}}
)
select * from returns