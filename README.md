# template-ruby-grape-api

|          |Master   |Develop|
|----------|---------|-------|
|**Status**|[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=master)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=develop)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|

Está documentação também está disponível em [Português do Brasil](README_pt-br.md).

Purpose of this project is to offer a template for create an API in [Ruby language](https://www.ruby-lang.org) using [Grape API framework](http://www.ruby-grape.org/) inside docker container and propose a development architecture for APIs. This template has:

- An application docker container with Ruby language and their gems like Grape API Framework
- A database docker container with Postgresql 11
- A suggestion of directory structure for construct the application and their layers

In this project exist endpoint examples for **Project** and **Healthcheck** resources. We believe with these examples the developer can develop his/her application.

We will continue to improve this project according new ideas and suggestions appear, or according bugs are found.

## Dependencies

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Stack

- Database -> [Postgresql 11](https://www.postgresql.org/)
- Language -> [Ruby 2.6.4](http://ruby-doc.org/core-2.6.4/)
  - API Framework -> [Grape](https://github.com/ruby-grape/grape)
  - Web Server -> [Puma](http://puma.io/)
  - Database ORM -> [Sequel](https://github.com/jeremyevans/sequel)

## Quick start - *See the application working*

1. Build all containers:

    ```bash
    docker-compose build
    ```

2. Start container **development**:

    ```bash
    docker-compose up development
    ```

3. **Done!**

    You are able to use your API acessing http://localhost:3000. Try to check healthcheck endpoint: http://localhost:3000/healthcheck.

## Development Usage

### The Containers

This project uses four docker containers:
- **database**: Container that provides a Postgres database with two instances: *postgres_dev* and *postgres_test*.
- **development**: Container that executes the application. Depends on container *database*.
- **test**: Container that executes tests and linter. Depends on container *database*.
- **apiblueprint**: Container that executes API documentation server.

| Services         | Depends on | Objectives                                                                            |
|------------------|------------|---------------------------------------------------------------------------------------|
| **database**     |            | Creates Database Postgres container / Creates postgres_dev and postgres_test databases|
| **development**  | database   | Creates and executes application container                                            |
| **test**         | database   | Creates application test container                                                    |
| **apiblueprint** |            | Creates a API documentation server                                                    |

### Building Containers

To build all containers just execute following command:

```bash
docker-compose build
```

To build a only one container, execute:

```bash
docker-compose build <container-name>
```

### Starting application

The application container (**development**) connects in database container (**database**), this means that development container depends on database container. For start both containers you have to execute following command:

```bash
docker-compose up development
```

In case you want to hide output docker information, you need to add *-d* parameter: ```docker-compose up -d development```.

**Note:** in a first execution will be created database and its structure.

**Done!**

You are able to use your API acessing http://localhost:3000. Try to check healthcheck endpoint: http://localhost:3000/healthcheck.

### Create data examples

If you need to insert some data in development database, you can use the rake task *seeds* with the following command.

```bash
docker-compose run --rm development rake db:seeds
```

**Notes:**
- Rake command clear all database tables before populate

Some information about containers:
- **database**
  - **Port**: 5432
  - Databases created with ```docker/database/create-multiple-postgresql-databases.sh``` file: ```postgres_test``` and ```postgres_dev```

- **development**
  - **Port**: 3000

More information about *stop*, *start*, *restart*, *run* containers and so on, read [Docker Compose Documentation](https://docs.docker.com/compose/) and [Docker Documentation](https://docs.docker.com/).

### Execute tests

This project uses one more container only to executing tests. This container calls **test**. Create infrastructure for **test** container:

```bash
docker-compose up test
```

Execute all tests with following command:


```bash
docker-compose run --rm test bundle exec rspec
```

For execute just one file test, you can inform a file in end of command.

```bash
docker-compose run --rm test bundle exec rspec spec/services/healthcheck/get_service_spec.rb
```

This project uses [Rspec](https://relishapp.com/rspec/) Ruby gem as a test tool.

### Execute code analizer

Create infrastructure for **test** container:

```bash
docker-compose up test
```

This project uses [Rubocop](https://www.rubocop.org) Ruby gem as a Code Analizer tool, so analize all code with following command.

```bash
docker-compose run --rm test bundle exec rubocop
```

For analize just one file, you can inform a file in end of command.

```bash
docker-compose run --rm test bundle exec rubocop app/services/healthcheck/get_service.rb
```

### Code coverage

This project uses [Simplecov](https://github.com/colszowka/simplecov) Ruby gem as Code Coverage tool, so know about this project code coverage opening file [./coverage/index.html](./coverage/index.html) after execute all tests with *Rspec* command.


### Database Migrations

For execute database migrations:

```bash
docker-compose run --rm <container> rake db:migrate
```

This command removes container.

## API Blueprint Documentation

This project uses [API Blueprint](https://apiblueprint.org) as API Documentation, so you can edit file `doc.apib` with all documentation you need. To generate HTML file for this documentation and access it by Snowboard, you can use a simple docker-compose command:

```bash
docker-compose up apiblueprint
```

or use the following docker command:

```bash
docker run -it --rm -p 127.0.0.1:8088:8088/tcp -v $PWD:/doc quay.io/bukalapak/snowboard http -b 0.0.0.0:8088 --playground -c config/snowboard.yml doc.apib
```

To access API Blueprint local server documentation page, visit [http://localhost:8088](http://localhost:8088).

The `config/snowboard.yml` configuration file was created to enable interative API documentation. So, its possible to simulate an API.

### More information about documentation
- [API Blueprint](https://apiblueprint.org)

## Directory Structure

- **app** -> Main API Directory. Where is contained all API logic.
  - **endpoints** -> Endpoints logical construction and endpoint mounts, divided by versions (v1, v2, v3 ...). Each resource has a directory and each http method (get, post, put, delete, etc) has a file.
  - **entities** -> Presentation logic of Endpoints data result, divided by versions (v1, v2, v3 ...). Each resource has an Entity representation.
  - **errors** -> Has error classes customized.
  - **helpers** -> Helper classes or modules for use in API
  - **models** -> Keeps model classes bound or not with database tables.
  - **services** -> Contains every business logic for each operation. Each resource has a directory and each operation (get, create, update, delete) has a file.
  - **validators** -> Contains validators classes or modules used to services. Each resource has a directory and each operation has a file.
- **config** -> Contains application configuration files.
  - **environments** -> Each environment (test, development, production) is represented by a configuration file. Each file contains specific configuration for each environment.
  - **initializers** -> Has files that need to be load in the application initialization.
- **db** -> Contains files associated to database execution using or not an ORM.
  - **migrations** -> Contains Sequel ORM migrations files.
  - **seeds** -> Contains classes that create data examples in database.
- **docker** -> Has docker configuration files.
  - **app** -> Contains docker configuration files for application container.
  - **database** -> Contains docker configuration files for database container.
- **spec** -> Has all tests, classes and modules for support tests, factories, everything about tests. Each written test has to follow their directory structure.
  - **factories** -> Keeps every factories class (we are using [FactoryBot](https://github.com/thoughtbot/factory_bot)).
  - **endpoints** -> Contains tests for Endpoints.
  - **models** -> Contains tests for Models.
  - **services** -> Contains tests for Services.
  - **commands** -> Contains tests for Commands.

## Additional information

- Dockerfile for Postgresql 11 (Container Docker) got on official [Postgresql Dockerfile](https://hub.docker.com/_/postgres/)

- Dockerfile for Ruby (Container Docker) got on official [Ruby Dockerfile](https://hub.docker.com/_/ruby/)

- [Design Patterns in Ruby](https://github.com/davidgf/design-patterns-in-ruby)
