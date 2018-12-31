require_relative "application"

class API < Grape::API
  format :json
  version :v1

  namespace :healthcheck do
    mount Endpoints::V1::Healthcheck
  end

  namespace :app do
    mount Endpoints::V1::App
  end
end

puts '**** Routes API ****'
API.routes.each do |route|
  puts route.instance_variable_get :@options
end

run API
