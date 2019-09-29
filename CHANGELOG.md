# Changelog
Here you can know about project evolution.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
### Added
- Created container **app_test** only for execute tests
- Set docker image in docker-compose.yml file for database service

### Changed
- Load environments variable from **application.rb** file to **docker-compose.yml** file
- Modified name App container from **app** to **app_development**
- TravisCi uses docker-compose for its execution
- Become validators simpler than previous approach
- Renamed app files to find them an easy way
- Upgraded gem versions
- Improved use of ***require*** commands in files
- Changed Healthcheck endpoint from ***v1*** level to ***top*** level

### Removed
- Deleted Dockerfile database

## [1.4.0] - 2019-06-02
### Changed
- Database image container from alpine:3.8 to postgres:11-alpine

### Added
- Script ```docker/database/create-multiple-postgresql-databases.sh``` to create multiple postgres databases based on **POSTGRES_MULTIPLE_DATABASES** docker-compose variable

## [1.3.0] - 2019-04-01
### Added
- Travis CI configuration

### Changed
- App image container from ruby:2.5.3-alpine to ruby:2.6.2-alpine
- Update bundler version in App Dockerfile
- Update gems version

## [1.2.0] - 2019-03-30
### Added
- Changelog file

### Changed
- App image container from ruby:2.5.3 to ruby:2.5.3-alpine

## [1.1.0] - 2019-03-30
### Added
- SwaggerUI container
- Endpoints Grape Documentation

## [1.0.0] - 2019-02-02
### Added
- Seeds for insert database records
- Endpoint for healthcheck
- CRUD endpoints for app resource
- Created project with Grape Framework, Postgresql docker and App docker
