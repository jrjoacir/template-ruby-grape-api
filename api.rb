class API < Grape::API
  format :json
  version :v1

  rescue_from Errors::NotFound do |e|
    error!({ message: e.message, with: Endpoints::Entities::Error }, 404)
  end

  rescue_from Errors::AlreadyExist do |e|
    error!({ message: e.message, with: Endpoints::Entities::Error }, 409)
  end

  mount Endpoints::V1::Mounts::Healthcheck
  mount Endpoints::V1::Mounts::App
end
