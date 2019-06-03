# template-ruby-grape-api

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
- Language -> [Ruby 2.6.2](http://ruby-doc.org/core-2.6.2/)
  - API Framework -> [Grape](https://github.com/ruby-grape/grape)
  - Web Server -> [Puma](http://puma.io/)
  - Database ORM -> [Sequel](https://github.com/jeremyevans/sequel)

## Development Usage

### Building and Start Containers

This project uses two docker containers: a **database** and an **application** container. The application container (calls **app**) connects in database container (calls **database**), this means that app container depends on database container. For start both containers you have to execute following command:

```bash
docker-compose up app
```

In case you want to hide output docker information, you need to add *-d* parameter: ``` docker-compose up -d app ```.

**Done!**

You are able to use your API acessing http://localhost:3000. Try to check healthcheck endpoint: http://localhost:3000/v1/healthcheck.

Some information about containers:
- **database**
  - **Port**: 5432
  - Databases created with ```docker/database/create-multiple-postgresql-databases.sh``` file: ```postgres_test``` and ```postgres_dev```

- **application**
  - **Port**: 3000
  - Web Server started with ```docker/app/entrypoint.sh``` file

More information about *stop*, *start*, *restart* containers and so on, read [Docker Compose Documentation](https://docs.docker.com/compose/) and [Docker Documentation](https://docs.docker.com/).

### Executing Tests

This project uses [Rspec](https://relishapp.com/rspec/) Ruby gem as a test tool, so execute all tests with following command.

```bash
docker-compose exec app rspec
```

For execute just one file test, you can inform a file in end of command.

```bash
docker-compose exec app rspec spec/services/healthcheck/get_spec.rb
```

### Executing Code Analizer

This project uses [Rubocop](https://www.rubocop.org) Ruby gem as a Code Analizer tool, so analize all code with following command.

```bash
docker-compose exec app rubocop
```

For analize just one file, you can inform a file in end of command.

```bash
docker-compose exec app rubocop app/services/healthcheck/get.rb
```

### Executing Code Coverage

This project user [Simplecov](https://github.com/colszowka/simplecov) Ruby gem as Code Coverage tool, so know about this project code coverage opening file [./coverage/index.html](./coverage/index.html) after execute all tests with *Rspec* command.

## Rake Tasks

For this project we decided to use a Ruby gem calls [Rake](https://github.com/ruby/rake) for execute some tasks.

### Database Migrations

For execute database migrations:

```bash
docker-compose exec app rake db:migrate
```

In case an environment is not informed, **Development** environment is used, but if you want to choose an environment you need to inform it in RACK_ENV variable.

```bash
docker-compose exec app rake db:migrate RACK_ENV=development
```

### Data Examples

If you need to insert some data in database, you can use the rake task *seeds* with the following command.

```bash
docker-compose exec app rake db:seeds
```

**Note**: This rake task only insert data in development database.

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
  - **commands** -> Keeps classes or modules with one specific action
  - **endpoints** -> Endpoints logical construction and endpoint mounts, divided by versions (v1, v2, v3 ...). Each resource has a directory and each http method (get, post, put, delete, etc) has a file.
  - **helpers** -> Helper classes or modules for use in API
  - **entities** -> Presentation logic of Endpoints data result, divided by versions (v1, v2, v3 ...). Each resource has an Entity representation.
  - **errors** -> Has error classes customized.
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
