{{ config(
    materialized='table'
) }}

with cleaned as (
    select
        payment_id,
        order_id,
        payment_amount,
        date_trunc('day', now() - (random() * interval '365 days')) as payment_date,
        row_number() over (partition by payment_id order by payment_id) as rn
    from {{ source('raw_data', 'raw_payments') }}
    where order_id is not null
)

select
    payment_id,
    order_id,
    payment_amount,
    payment_date
from cleaned
where rn = 1