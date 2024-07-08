-- imports

with source_order_detail as (
    select * from {{ ref('raw_order_details') }}
),

-- lógica de negócio

order_detail_renamed_cleaning as (
    select
        order_id,
        product_id,
        unit_price,
        quantity,
        discount
    from
        source_order_detail
)

-- query final

select * from order_detail_renamed_cleaning
