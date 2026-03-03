{{ config(
    materialized='table'
) }}

with cleaned as (
    select
        customer_id,
        full_name,
        lower(trim(email)) as email,
        cast(created_at as date) as created_at,
        row_number() over (partition by customer_id order by created_at desc) as rn
    from {{ source('raw_data', 'raw_customers') }}
    where email is not null
)

select
    customer_id,
    full_name,
    email,
    created_at
from cleaned
where rn = 1