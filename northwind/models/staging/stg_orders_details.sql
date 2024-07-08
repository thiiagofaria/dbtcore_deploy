-- imports

with source_order_detail as (
    select * from {{ref('raw_order_details')}}
)

-- logícas de negócio

with order_detail_renamed_cleaning (
select
    order_id,
    product_id,
    unit_price,
    quantity,
    discount
from
    source_order_detail
)

-- Query final

select * from order_detail_renamed_cleaning