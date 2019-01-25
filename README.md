# container-smasher

## Dependencies

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Stack

- Database -> [Postgresql 11](https://www.postgresql.org/)
- Language -> [Ruby 2.5.3](http://ruby-doc.org/core-2.5.3/)
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

Done! You are able to use API acessing http://localhost:3000. Try to check healthcheck endpoint: http://localhost:3000/v1/healthcheck.

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

### Code Coverage

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

### (Re)Create Test Database

It is possible create and recreate the Test database just executing a rake task.

```bash
docker-compose exec app rake db:create_test_database
```

## Directory Structure

- **app** -> Main API Directory. Where is contained all API logic.
  - **endpoints** -> Processing logic of endpoints
    - **entities** -> Presentation logic of Endpoints data result. Each resource has an Entity representation.
    - **v1** -> Endpoints logical construction (version 1) and endpoint mounts. Each resource has a directory and each http method (get, post, put, delete, etc) has a file.
    - **helpers** -> Helper classes or modules for use in API mounts
  - **errors** -> Has error classes customized.
  - **models** -> Keeps model classes bound or not with database tables.
  - **services** -> Contains every business logic for each operation. Each resource has a directory and each operation (get, create, update, delete) has a file.
  - **validators** -> Contains validators classes or modules used to services. Each resource has a directory and each operation has a file.
- **config** -> Contains application configuration files.
  - **environments** -> Each environment (test, development, production) is represented by a configuration file. Each file contains specific configuration for each environment.
  - **initializers** -> Has files that need to be load in the application initialization.
- **db** -> Contains files associated to database execution using or not an ORM.
  - **migrations** -> Contains Sequel ORM migrations files.
- **docker** -> Has docker configuration files.
  - **app** -> Contains docker configuration files for application container.
  - **database** -> Contains docker configuration files for database container.
- **spec** -> Has all tests, classes and modules for support tests, factories, everything about tests. Each written test has to follow their directory structure.
  - **factories** -> Keeps every factories class (we are using [FactoryBot](https://github.com/thoughtbot/factory_bot)).
  - **support** -> Has every need to help test classes.
  - **endpoints** -> Contains tests for Endpoints.
  - **models** -> Contains tests for Models.
  - **services** -> Contains tests for Services.

## Additional information (Draft)

- Postgresql 11 (Container Docker)
    - Dockerfile got on official Postgresql Dockerfile (https://hub.docker.com/_/postgres/)
    - Build Docker Container with a good name: docker build -t postgresql:container-smasher ./database/config/docker
    - Execute container (connect in database): docker run postgres:latest -e POSTGRES_PASSWORD=mysecretpassword -d postgres
    **** - Execute commands inside container (connect in database): docker exec --name container-smasher -e POSTGRES_PASSWORD=mysecretpassword -d postgres

- Ruby 2.5 (Container Docker)
    - Dockerfile got on official Postgresql Dockerfile (https://hub.docker.com/_/ruby/)
    - Build Docker Container with a good name: docker build -t ruby:container-smasher .
    - Execute container (execute bundle install): docker run ruby:container-smasher bundle install
    **** - Execute commandas inside container (execute IRB):
        - docker exec --name ruby:container-smasher irb
        - docker-compose run --rm app irb

- Execute migration: docker-compose exec app rake db:migrate RACK_ENV=development

- Importante links:
  - Docker
      - https://hub.docker.com/_/postgres/
      - http://flaviosilveira.com/2017/criando-seu-container-com-dockerfile/

  