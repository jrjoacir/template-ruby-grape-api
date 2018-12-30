# container-smasher

Dependencies

- Docker

Stack

Postgresql 11 (Container Docker)
    - Dockerfile got on official Postgresql Dockerfile (https://hub.docker.com/_/postgres/)
    - Build Docker Container with a good name: docker build -t postgresql:container-smasher ./database/config/docker
    - Execute container (connect in database): docker run postgres:latest -e POSTGRES_PASSWORD=mysecretpassword -d postgres
    **** - Execute commands inside container (connect in database): docker exec --name container-smasher -e POSTGRES_PASSWORD=mysecretpassword -d postgres

Ruby 2.5 (Container Docker)
    - Dockerfile got on official Postgresql Dockerfile (https://hub.docker.com/_/ruby/)
    - Build Docker Container with a good name: docker build -t ruby:container-smasher .
    - Execute container (execute bundle install): docker run ruby:container-smasher bundle install
    **** - Execute commandas inside container (execute IRB):
        - docker exec --name ruby:container-smasher irb
        - docker-compose run --rm app irb

Importante links:
- Docker
    - https://hub.docker.com/_/postgres/
    - http://flaviosilveira.com/2017/criando-seu-container-com-dockerfile/
