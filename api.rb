# frozen_string_literal: true

class API < Grape::API
  use GrapeLogging::Middleware::RequestLogger unless ENV['RACK_ENV'] == 'test'
  format :json
  helpers HelpersApp::APIErrors

  rescue_from Errors::Http, with: :error

  mount Endpoints::Mounts::Healthcheck

  version :v1

  mount Endpoints::V1::Mounts::Project

  add_swagger_documentation(api_version: 'v1',
                            format: :json,
                            schemes: 'http',
                            info: {
                              title: 'Template Ruby Grape API',
                              description: 'Documentation for version 1 API'
                            })
end
