-- config



-- IMPORT

with products as (
    select
        product_id,
        product_name
    from 
        "northwind"."public"."stg_products"
),
order_details as (
    select
        product_id,
        unit_price,
        quantity,
        discount
    from
        "northwind"."public"."stg_orders_details"
)

-- REGRA DE NEGOCIO

, report_top_10_products as (
    select
        products.product_name, 
        sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as sales
    from 
        products
    inner join 
        order_details on order_details.product_id = products.product_id
    group by 
        products.product_name
    order by 
        sales desc
    limit 10
)

-- QUERY FINAL

select * from report_top_10_products