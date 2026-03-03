{{ config(
    materialized='table'
) }}

select
    c.customer_id,
    c.full_name,
    c.email,
    c.created_at as customer_created_at,
    o.order_id,
    o.order_date,
    o.amount as order_amount,
    p.payment_id,
    p.payment_amount,
    p.payment_date
from {{ ref('stg_customers') }} c
left join {{ ref('stg_orders') }} o
    on c.customer_id = o.customer_id
left join {{ ref('stg_payments') }} p
    on o.order_id = p.order_id