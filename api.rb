# frozen_string_literal: true

class API < Grape::API
  use GrapeLogging::Middleware::RequestLogger unless ENV['RACK_ENV'] == 'test'
  format :json
  helpers HelpersApp::APIErrors

  rescue_from Errors::NotFound, with: :not_found
  rescue_from Errors::AlreadyExist, with: :conflict

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  mount Endpoints::Mounts::Healthcheck

  version :v1

  mount Endpoints::V1::Mounts::App

  add_swagger_documentation(api_version: 'v1',
                            format: :json,
                            schemes: 'http',
                            info: {
                              title: 'Template Ruby Grape API',
                              description: 'Documentation for version 1 API'
                            })
end
