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

## Directory structure

- **app** -> Main API Directory. Where is contained all API logic.
  - **endpoints** -> Processing logic of endpoints
    - **entities** -> Presentation logic of Endpoints data result. Each resource has an Entity representation.
    - **v1** -> Endpoints logical construction (version 1). Each resource has a directory and each http method (get, post, put, delete, etc) has a file.
  - **errors** -> Has error classes customized.
  - **models** -> Keep model classes bound or not with database tables.
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

  