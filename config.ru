require 'grape'
require 'grape-entity'
require_relative 'app/endpoints/entities/healthcheck'
require_relative 'app/endpoints/v1/healthcheck'
require_relative 'app/models/healthcheck'
require_relative 'app/services/healthcheck'

class API < Grape::API
  format :json
  version :v1

  namespace :healthcheck do
    mount Endpoints::V1::Healthcheck
  end
end

puts '**** Routes API ****'
API.routes.each do |route|
  puts route.instance_variable_get :@options
end

run API
