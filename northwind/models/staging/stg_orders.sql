-- imports

with orders_source as (
    select * from {{ ref('raw_orders') }}
),

-- lógica de negócio

orders_renamed_cleaning as (
    select
        order_id,
        customer_id,
        employee_id,
        order_date,
        required_date,
        shipped_date,
        ship_via,
        freight,
        ship_name,
        ship_address,
        ship_city,
        ship_region,
        ship_postal_code,
        ship_country
    from
        orders_source
)

-- query final

select * from orders_renamed_cleaning
