# Changelog
Here you can know about project evolution.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
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
