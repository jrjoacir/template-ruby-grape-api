# container-smasher

Dependencies

- Docker

Stack

Postgresql 11 (Container Docker)
    - Dockerfile got on official Postgresql Dockerfile (https://hub.docker.com/_/postgres/)
    - Build Docker Container with a good name: docker build -t postgresql:container-smasher ./docker/postgres
    - Execute container: docker run --name container-smasher-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres


Importante links:
- Docker
    - https://hub.docker.com/_/postgres/
    - http://flaviosilveira.com/2017/criando-seu-container-com-dockerfile/
