
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

## Estrutura dos Modelos

Os modelos dbt estão localizados no diretório `northwind`. Este diretório pode conter subdiretórios como `models`, `seeds`, `snapshots`, entre outros, dependendo da organização do seu projeto.

### Exemplos de Modelos

- **models/**: Contém os modelos SQL que transformam os dados.
- **seeds/**: Contém dados estáticos que podem ser carregados no banco de dados.
- **snapshots/**: Contém definições de snapshots para capturar o estado histórico dos dados.

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Para começar:

1. Faça um fork do projeto.
2. Crie uma nova branch (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`).
4. Faça um push para a branch (`git push origin feature/nova-feature`).
5. Crie um novo Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.
