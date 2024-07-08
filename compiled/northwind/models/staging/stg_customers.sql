-- imports

with customer_source as (
    select * from "northwind"."public"."raw_customers"
),

-- lógica de negócio

customer_renamed_cleaning as (
    select
        customer_id,
        company_name,
        contact_name,
        contact_title,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax
    from
        customer_source
)

-- query final

select * from customer_renamed_cleaning