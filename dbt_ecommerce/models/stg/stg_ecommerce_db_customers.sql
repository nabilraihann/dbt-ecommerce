{{
  config(
    unique_key='customer_id'
  )
}}

with customers as (
  select * from {{ source('ecommerce_db','customers')}}
)
select * from customers

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
  where elt_loaded_at >= (select coalesce(max(elt_loaded_at), '1900-01-01') from {{ this }})

{% endif %}