{{ config(
    schema='gold',
    materialized='table'
) }}

select * from {{ref('raw_customers')}}