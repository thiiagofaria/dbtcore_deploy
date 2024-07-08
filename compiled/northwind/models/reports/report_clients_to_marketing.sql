-- config


-- IMPORT

with clientes_com_pedidos as (
    select 
        customers.customer_id,
        customers.company_name, 
        orders.order_id,
        order_details.unit_price,
        order_details.quantity,
        order_details.discount
    from 
        "northwind"."public"."stg_customers" as customers
    inner join 
        "northwind"."public"."stg_orders" as orders on customers.customer_id = orders.customer_id
    inner join 
        "northwind"."public"."stg_orders_details" as order_details on order_details.order_id = orders.order_id
)

-- REGRA DE NEGOCIO

, clientes_para_marketing as (
    select 
        company_name, 
        sum(unit_price * quantity * (1.0 - discount)) as total,
        ntile(5) over (order by sum(unit_price * quantity * (1.0 - discount)) desc) as group_number
    from 
        clientes_com_pedidos
    group by 
        company_name
    order by 
        total desc
)

-- QUERY FINAL

select *
from clientes_para_marketing
where group_number >= 3