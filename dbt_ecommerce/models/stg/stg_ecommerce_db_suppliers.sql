with suppliers as (
  select * from {{ source('ecommerce_db','suppliers')}}
)
select * from suppliers