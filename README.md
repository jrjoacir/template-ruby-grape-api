# template-ruby-grape-api

|Branches|Status   |
|--------|---------|
|master  |[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=master)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|
|develop |[![Build Status](https://travis-ci.com/jrjoacir/template-ruby-grape-api.svg?branch=develop)](https://travis-ci.com/jrjoacir/template-ruby-grape-api)|

Purpose of this project is to offer a template for create an API in [Ruby language](https://www.ruby-lang.org) using [Grape API framework](http://www.ruby-grape.org/) inside docker container and propose a development architecture for APIs. This template has:

- An application docker container with Ruby language and their gems like Grape API Framework
- A database docker container with Postgresql 11
- A suggestion of directory structure for construct the application and their layers

In this project exist endpoint examples for **App** and **Healthcheck** resources. We believe with these examples a developer can develop his/her application, but we intend to make a step-by-step soon.

We continue to improve this project according new ideas and suggestions appear, or according bugs are found.

## Dependencies

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Stack

- Database -> [Postgresql 11](https://www.postgresql.org/)
- Language -> [Ruby 2.6.4](http://ruby-doc.org/core-2.6.4/)
  - API Framework -> [Grape](https://github.com/ruby-grape/grape)
  - Web Server -> [Puma](http://puma.io/)
  - Database ORM -> [Sequel](https://github.com/jeremyevans/sequel)

## Development Usage

### The Containers

This project uses four docker containers:
- **database**: Container that provides a Postgres database with two instances: *postgres_dev* and *postgres_test*.
- **migrate**: Container that only run migration task on database container. Depends on *migrate_app_development* and *migrate_app_test* containers.
- **migrate_app_development**: Container that only run migration task on development database container. Depends on database container.
- **migrate_app_test**: Container that only run migration task on test database container. Depends on database container.
- **app_development**: Container that executes the application. Depends on *database* and *migrate_app_development* containers.
- **app_test**: Container that executes tests and linter. Depends on *database* and *migrate_app_test* containers.

| Services                    | Depends on / Links                         | Objetives                                                                              |
|-----------------------------|--------------------------------------------|----------------------------------------------------------------------------------------|
| **database**                |                                            | Creates Database Postgres container / Creates postgres_dev and postgres_test databases |
| **app_development**         | database / migrate_app_development         | Creates and executes application container                                             |
| **app_test**                | database / migrate_app_test                | Creates application test container                                                     |
| **migrate**                 | migrate_app_development / migrate_app_test | Create a development database structure / Create a test database structure             |
| **migrate_app_development** | database                                   | Create a development database structure                                                |
| **migrate_app_test**        | database                                   | Create a test database structure                                                       |

### Building Containers

To build all containers just execute following command:

```bash
docker-compose build
```

To build a only one container, execute:

```bash
docker-compose build <container-name>
```

### Starting Container Application

The application container (calls **app_development**) connects in database container (calls **database**), this means that app container depends on database container. For start both containers you have to execute following command:

```bash
docker-compose up app_development
```

In case you want to hide output docker information, you need to add *-d* parameter: ```docker-compose up -d app_development```.

**Note:** in a first execution will be created database and its structure.

**Done!**

You are able to use your API acessing http://localhost:3000. Try to check healthcheck endpoint: http://localhost:3000/healthcheck.

### Data Examples

If you need to insert some data in development database, you can use the rake task *seeds* with the following command.

```bash
docker-compose run --rm app_development rake db:seeds
```

This command removes *app_development* container.

### Creating Database and execute migration

If you wish to just create database infrastructure on development and test databases, execute:

```bash
docker-compose up migrate
```

It will create database and execute migrations, creating database objects.

### Creating Development Database and execute migration

If you wish to just create development database infrastructure, execute:

```bash
docker-compose up migrate_app_development
```

It will create database and execute migrations, creating database objects.

### Creating Development Database and execute migration

If you wish to just create test database infrastructure, execute:

```bash
docker-compose up migrate_app_test
```

It will create database and execute migrations, creating database objects.

Some information about containers:
- **database**
  - **Port**: 5432
  - Databases created with ```docker/database/create-multiple-postgresql-databases.sh``` file: ```postgres_test``` and ```postgres_dev```

- **app_development**
  - **Port**: 3000

More information about *stop*, *start*, *restart*, *run* containers and so on, read [Docker Compose Documentation](https://docs.docker.com/compose/) and [Docker Documentation](https://docs.docker.com/).

### Executing Tests

This project uses one more container only to executing tests. This container calls **app_test**.

Supposing app_test container is builded, execute all tests with following command:

```bash
docker-compose run --rm app_test rspec
```

For execute just one file test, you can inform a file in end of command.

```bash
docker-compose run --rm app_test rspec spec/services/healthcheck/get_service_spec.rb
```

Both commands remove *app_test* container.

This project uses [Rspec](https://relishapp.com/rspec/) Ruby gem as a test tool.

### Executing Code Analizer

This project uses [Rubocop](https://www.rubocop.org) Ruby gem as a Code Analizer tool, so analize all code with following command.

```bash
docker-compose run --rm app_test rubocop
```

For analize just one file, you can inform a file in end of command.

```bash
docker-compose run --rm app_test rubocop app/services/healthcheck/get_service.rb
```

Both commands remove *app_test* container.

### Executing Code Coverage

This project user [Simplecov](https://github.com/colszowka/simplecov) Ruby gem as Code Coverage tool, so know about this project code coverage opening file [./coverage/index.html](./coverage/index.html) after execute all tests with *Rspec* command.

## Rake Tasks

For this project we decided to use a Ruby gem calls [Rake](https://github.com/ruby/rake) for execute some tasks.

### Database Migrations

For execute database migrations:

```bash
docker-compose run --rm <app-container> rake db:migrate
```

This command removes container.

## Swagger Documentation (experimental)

This project has a docker container to start a Swagger documentation server. This container calls **swagger** and you can start it with the following docker-compose command:

```bash
docker-compose up swagger
```

To access Swagger documentation page, visit [http://localhost](http://localhost), inform **http://localhost:3000/v1/swagger_doc** in explore bar and press Explore to see project documentation API. Some funcionalities still don't work in this project version.

In case you want to hide output docker information, you need to add *-d* parameter: ```docker-compose up -d swagger```.

### About this container

- **swagger**
  - **Port**: 80

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
  - **swagger** -> Contains docker configuration files for swagger container.
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
