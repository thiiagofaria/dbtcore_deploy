-- imports

with product_source as (
    select * from "northwind"."public"."raw_products"
),

-- lógica de negócio

products_renamed_cleaning as (
    select
        product_id,
        product_name,
        supplier_id,
        category_id,
        quantity_per_unit,
        unit_price,
        units_in_stock,
        units_on_order,
        reorder_level,
        discontinued
    from
        product_source
)

-- query final

select * from products_renamed_cleaning