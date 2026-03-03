{{ config(
    materialized='table'
) }}

with cleaned as (
    select
        order_id,
        customer_id,
        cast(created_at as date) as order_date,   -- created_at kolonunu order_date olarak normalize ediyoruz
        amount,
        row_number() over (partition by order_id order by created_at desc) as rn
    from {{ source('raw_data', 'raw_orders') }}
    where customer_id is not null
)

select
    order_id,
    customer_id,
    order_date,
    amount
from cleaned
where rn = 1