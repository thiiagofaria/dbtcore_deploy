-- models/reporting/uk_clients_who_pay_more_than_1000.sql



-- IMPORT

with clientes_com_pedidos_uk as (
    select 
        customers.contact_name,
        order_details.unit_price,
        order_details.quantity,
        order_details.discount
    from 
        "northwind"."public"."stg_customers" as customers
    inner join 
        "northwind"."public"."stg_orders" as orders on orders.customer_id = customers.customer_id
    inner join 
        "northwind"."public"."stg_orders_details" as order_details on order_details.order_id = orders.order_id
    where 
        lower(customers.country) = 'uk'
)

-- REGRA DE NEGOCIO

, pagamentos_por_cliente as (
    select 
        contact_name, 
        sum(unit_price * quantity * (1.0 - discount)) as payments
    from 
        clientes_com_pedidos_uk
    group by 
        contact_name
    having 
        sum(unit_price * quantity * (1.0 - discount)) > 1000
)

-- QUERY FINAL

select 
    contact_name, 
    payments
from 
    pagamentos_por_cliente