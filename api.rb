class API < Grape::API
  format :json
  version :v1

  rescue_from Errors::Business::NotFound do |e|
    error!({ message: e.message, with: Endpoints::Entities::Error }, 404)
  end

  rescue_from Errors::Business::AlreadyExist do |e|
    error!({ message: e.message, with: Endpoints::Entities::Error }, 409)
  end

  namespace :healthcheck do
    mount Endpoints::V1::Healthcheck::Get
  end

  namespace :app do
    mount Endpoints::V1::App::Post
    mount Endpoints::V1::App::Delete
    mount Endpoints::V1::App::Put
    mount Endpoints::V1::App::Get
  end
end
