# template-ruby-grape-api

|          |Master   |Develop|
|----------|---------|-------|
|**Status**|[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=master)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=develop)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|

This documentation is also available in [English](README.md).

A proposta deste projeto é oferecer um *template* para se criar uma API na linguagem [Ruby](https://www.ruby-lang.org) usando o *API Framework* [Grape](http://www.ruby-grape.org/) dentro de um container docker e propor uma arquitetura de desenvolvimento de APIs. Este template possui:

- Uma aplicação dentro de um contêiner docker com a linguagem Ruby e suas *gems* como o framework *Grape*.
- Contêiner docker com o banco de dados Postgresql 12
- Uma sugestão de estrutura de diretórios para construir a aplicação e suas camadas

Neste projeto existem exemplos de *endpoints* para os recursos **Project** e **Healthcheck**. Nós acreditamos que com estes exemplos qualquer desenvolvedor ou desenvolvedora possa desenvolver APIs.

Nós continuaremos a evoluir este projeto conforme novas ideias e sugestões surjam, ou conforme erros sejam encontrados.

## Dependências

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## *Stack* tecnológica

- Banco de dados -> [Postgresql 12](https://www.postgresql.org/)
- Language -> [Ruby 2.6.4](http://ruby-doc.org/core-2.6.4/)
  - API Framework -> [Grape](https://github.com/ruby-grape/grape)
  - Servidor Web -> [Puma](http://puma.io/)
  - ORM -> [Sequel](https://github.com/jeremyevans/sequel)

## Início rápido - *Veja a aplicação funcionando*

1. *Buildando* todos os contêineres:

    ```bash
    docker-compose build
    ```

2. Iniciando o contêiner **development**:

    ```bash
    docker-compose up development
    ```

3. **Pronto!**

    Você já pode acessar sua API através de http://localhost:3000. Tente checar o *endpoint* healthcheck: http://localhost:3000/healthcheck.

## Desenvolvendo

### Os Contêineres

Este projeto usa quatro contêineres docker:

- **database**: Contêiner que fornece um banco de dados Postgres com duas instâncias: *postgres_dev* e *postgres_test*.
- **development**: Contêiner que executa a aplicação. Ele depende do contêiner *database*.
- **test**: Contêiner que executa testes e analizador de código. Ele depende do contêiner *database*.
- **apiblueprint**: Contêiner que executa o servidor de documentação de API.

| Serviços         | Depende do serviço | Objetivos                                                                                        |
|------------------|--------------------|--------------------------------------------------------------------------------------------------|
| **database**     |                    | Cria o contêiner de banco de dados com Postgres / Cria as instâncias postgres_dev e postgres_test|
| **development**  | database           | Cria e executa o contêiner da aplicação                                                          |
| **test**         | database           | Cria o contêiner de teste da aplicação                                                           |
| **apiblueprint** |                    | Cria o servidor de documentação da API                                                           |

### *Buildando* Contêineres

Para *buildar* todos os contêineres basta executar o seguindo comando:

```bash
docker-compose build
```

Para *buildar* apenas um contêiner, execute:

```bash
docker-compose build <name-do-contêiner>
```

### Iniciando a aplicação

O contêiner da aplicação (**development**) se conecta ao contêiner de banco de dados (**database**), isto significa que o contêiner *development* depende do contêiner *database*. Para iniciar ambos contêineres você deve executar o seguinte comando:

```bash
docker-compose up development
```

Caso você queira esconder as mensagens de informações do docker, você precisa adicionar o parâmetro *-d*: ```docker-compose up -d development```.

**Observação:** na primeira execução será criado o banco de dados e sua estrutura.

**Pronto!**

Você já pode acessar sua API acessando http://localhost:3000. Tente checar o *endpoint* healthcheck: http://localhost:3000/healthcheck.

### Criar dados de exemplo

Se você precisar inserir alguns dados de exemplo no banco de dados, você pode usar a *rake task* **seeds** através do comando abaixo.


```bash
docker-compose run --rm development rake db:seeds
```

**Observação:**
- Este comando *rake* apagará todos os dados das tabelas antes de populá-las

Algunas informações sobre os contêineres:
- **database**
  - **Porta**: 5432
  - Instâncias criadas com o arquivo ```docker/database/create-multiple-postgresql-databases.sh```: ```postgres_test``` e ```postgres_dev```

- **development**
  - **Porta**: 3000

Mais informações sobre *parar*, *iniciar*, *reiniciar*, *executar* contêineres e mais, leia a [Documentação do Docker Compose](https://docs.docker.com/compose/) e a [Documentação do Docker](https://docs.docker.com/).


### Executar testes

Este projeto usa mais um contêiner apenas para a execução de testes. Este contêiner se chama **test**. Criar infraestrutura para o contêiner **test**:

```bash
docker-compose up test
```

Execute todos os testes com o seguinte comando:


```bash
docker-compose run --rm test rspec
```

Para executar testes de apenas um arquivo, você deve informar o arquivo no final do comando.

```bash
docker-compose run --rm test rspec spec/services/healthcheck/get_service_spec.rb
```

Este projeto utilizada a gem [Rspec](https://relishapp.com/rspec/) para linguagem Ruby como uma ferramenta de execução de testes.

### Executar o analizador de código

Criar a infraestrutura para o contêiner **test**:


```bash
docker-compose up test
```

Este projeto utilizada a gem [Rubocop](https://www.rubocop.org) para linguagem Ruby como uma ferramenta de análise de código, então para analizar todo o código execute o seguinte comando.

```bash
docker-compose run --rm test rubocop
```

Para analizar o código de um arquivo, você deve informar o arquivo no final do comando.

```bash
docker-compose run --rm test rubocop app/services/healthcheck/get_service.rb
```

### Cobertura de testes do código

Este projeto utilizada a gem [Simplecov](https://github.com/colszowka/simplecov) para linguagem Ruby como um ferramenta de cobertura de testes do código, então para saber mais sobre a cobertura abra o arquivo [./coverage/index.html](./coverage/index.html) no seu navegador após a execução de todos os testes com o comando *rspec*.


### Migração de banco de dados

Para executar os arquivos de migração de banco de dados:


```bash
docker-compose run --rm <container> rake db:migrate
```

Este comando remove o contêiner.

## Documentação de API no formato Blueprint

Este projeto utilizada o formato [API Blueprint](https://apiblueprint.org) como documentação de API, então você deve editar o arquivo `doc.apib` que contém toda a documentação que necessita. Para gerar um arquivo HTML com a documentação e acessá-la através do *Snowboard*, você pode usar um simples comando do *docker-compose*:

```bash
docker-compose up apiblueprint
```

ou usar o comando *docker* abaixo:

```bash
docker run -it --rm -p 127.0.0.1:8088:8088/tcp -v $PWD:/doc quay.io/bukalapak/snowboard http -b 0.0.0.0:8088 --playground -c config/snowboard.yml doc.apib
```

Para acessar o servidor local da documentação em API Blueprint, visite o endereço [http://localhost:8088](http://localhost:8088).


O arquivo de configuração `config/snowboard.yml` foi criado para habilitar a documentação interativa. Com ela é possível simular a API.

### Mais informações sobre documentação
- [API Blueprint](https://apiblueprint.org)

## Estrutura de diretórios

- **app** -> O diretório principal da API. Contém toda a lógica da API.
  - **endpoints** -> Lógica da construção dos *endpoints* e suas montagens, dividido por versões (v1, v2, v3 ...). Cada recurso possui um diretório e cada método http (get, post, put, delete, etc) possui um arquivo.
  - **entities** -> Lógica da apresentação do resultado do *endpoint*, dividido por versões (v1, v2, v3 ...). Cada recurso possui uma entidade de representação.
  - **errors** -> Possui classes de erros customizados.
  - **helpers** -> Classes ou módulos do tipo *helper* para uso na API.
  - **models** -> Armazena as classes modelo vinculadas ou não à uma tabela do banco de dados.
  - **services** -> Contém toda a lógica de negócio para cada operação. Cada recurso possuir um diretório e cada operação (get, create, update, delete) possui um arquivo.
  - **validators** -> Contém classes ou módulos de validação que são utilizadas pelas *services*. Cada recurso possui um diretório e cada operação tem um arquivo.
- **config** -> Contém arquivos de configuração da aplicação.
  - **environments** -> Cada ambiente (test, development, production) é representado por um arquivo de configuração. Cada arquivo contém configurações específicas para cada ambiente.
  - **initializers** -> Possui arquivo que precisam ser carregados no momento de inicializar a aplicação.
- **db** -> Contém arquivo associados com a execução do banco de dados usando ou não um *ORM*.
  - **migrations** -> Contém arquivos de migração de banco de dados utilizando o *ORM* **Sequel**.
  - **seeds** -> Contém classes que criam os dados de exemplo no banco de dados.
- **docker** -> Possui os arquivos de configurações do *docker*.
  - **app** -> Contém os arquivos de configuração para os contêineres da aplicação.
  - **database** -> Contém os arquivos de configuração para o contêiner **database**.
- **spec** -> Possui todos os teste, classes e módulos que auxiliam os testes, *factories*, tudo sobre testes. Cada teste escrito deve seguir sua estrutura de diretórios.
  - **factories** -> Armazena todas as classes **Factory** (estamos usando a gem [FactoryBot](https://github.com/thoughtbot/factory_bot)).
  - **endpoints** -> Contém todos os testes de *endpoints*.
  - **models** -> Contém todos os testes de *models*.
  - **services** -> Contém todos os testes de *services*.
  - **commands** -> Contém todos os testes de *commands*.

## Informações adicionais

- O *Dockerfile* para Postgresql 12 foi obtido no repositório oficial: [Postgresql Dockerfile](https://hub.docker.com/_/postgres/)

- O *Dockerfile* contendo a linguagem Ruby foi obtido no repositório oficial: [Ruby Dockerfile](https://hub.docker.com/_/ruby/)

- [Design Patterns in Ruby](https://github.com/davidgf/design-patterns-in-ruby)
