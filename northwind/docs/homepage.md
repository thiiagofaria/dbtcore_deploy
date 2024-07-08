{% docs __overview__ %}


# dbtcore_deploy

Este projeto utiliza o dbt (data build tool) para transformar e modelar dados do banco de dados Northwind. O objetivo é criar uma pipeline de dados eficiente e bem estruturada para análise e relatórios.

## Visão Geral

O `dbtcore_deploy` é um projeto de modelagem de dados que transforma dados brutos do banco de dados Northwind em modelos analíticos prontos para uso. Este projeto contém todas as configurações, scripts SQL, e documentação necessária para gerenciar e transformar esses dados.

## Estrutura do Projeto

A estrutura do diretório do projeto é a seguinte:

```
dbtcore_deploy/
├── .github/
│   └── workflows/
├── logs/
├── northwind/
│   ├── models/
│   │   ├── staging/
│   │   │   └── staging_northwind.sql
│   │   ├── marts/
│   │   │   ├── customers.sql
│   │   │   ├── orders.sql
│   │   │   └── products.sql
│   ├── seeds/
│   ├── snapshots/
│   └── ...
├── .gitignore
├── .user.yml
├── README.md
└── profiles.yml
```

### Diretórios e Arquivos Principais

- **.github/**: Contém configurações e workflows do GitHub Actions.
- **logs/**: Diretório onde os logs de execução do dbt são armazenados.
- **northwind/**: Diretório principal para modelos dbt, incluindo scripts SQL e outros arquivos de configuração.
- **.gitignore**: Lista de arquivos e diretórios que o Git deve ignorar.
- **.user.yml**: Arquivo de configuração do usuário.
- **README.md**: Documentação do projeto.
- **profiles.yml**: Arquivo de configuração do dbt.

## Configuração do Projeto

### Dependências

Certifique-se de ter o dbt instalado. Você pode instalar o dbt usando pip:

```sh
pip install dbt
```

### Configuração do Profile

O arquivo `profiles.yml` deve ser configurado com as credenciais do seu banco de dados. Um exemplo de configuração para um banco de dados PostgreSQL:

```yaml
northwind:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: user
      password: password
      port: 5432
      dbname: northwind
      schema: public
```

### Executando o dbt

Após configurar o `profiles.yml`, você pode executar os comandos dbt para rodar os modelos e testar os dados.

Para rodar todos os modelos:

```sh
dbt run
```

Para executar os testes:

```sh
dbt test
```

## Arquitetura de Dados e Transformações

### Modelos de Staging

Os modelos de staging são usados para preparar os dados brutos para transformações subsequentes. Eles aplicam limpeza básica, formatação e junções necessárias.

#### Exemplo: `staging_northwind.sql`

```sql
with raw_customers as (
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
    from {{ source('northwind', 'customers') }}
)

select * from raw_customers
```

### Modelos de Marts

Os modelos de marts são usados para criar tabelas analíticas específicas para diferentes áreas de negócios.

#### `customers.sql`

Modelo que agrega e transforma dados de clientes, calculando o número total de pedidos e o total gasto por cada cliente.

```sql
with customer_orders as (
    select
        c.customer_id,
        c.company_name,
        count(o.order_id) as total_orders,
        sum(od.quantity * od.unit_price) as total_spent
    from {{ ref('staging_northwind') }} c
    left join {{ ref('staging_orders') }} o on c.customer_id = o.customer_id
    left join {{ ref('staging_order_details') }} od on o.order_id = od.order_id
    group by c.customer_id, c.company_name
)

select * from customer_orders
```

#### `orders.sql`

Modelo que transforma dados de pedidos, incluindo informações sobre produtos pedidos e o valor total de cada pedido.

```sql
with order_details as (
    select
        o.order_id,
        o.order_date,
        o.customer_id,
        od.product_id,
        od.quantity,
        od.unit_price,
        (od.quantity * od.unit_price) as total_price
    from {{ ref('staging_orders') }} o
    left join {{ ref('staging_order_details') }} od on o.order_id = od.order_id
)

select * from order_details
```

#### `products.sql`

Modelo que transforma dados de produtos, incluindo informações sobre o total vendido e o valor total das vendas.

```sql
with product_sales as (
    select
        p.product_id,
        p.product_name,
        sum(od.quantity) as total_quantity_sold,
        sum(od.quantity * od.unit_price) as total_sales_value
    from {{ ref('staging_products') }} p
    left join {{ ref('staging_order_details') }} od on p.product_id = od.product_id
    group by p.product_id, p.product_name
)

select * from product_sales
```

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Para começar:

1. Faça um fork do projeto.
2. Crie uma nova branch (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`).
4. Faça um push para a branch (`git push origin feature/nova-feature`).
5. Crie um novo Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.


{% enddocs %}