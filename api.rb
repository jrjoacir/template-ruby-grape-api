class API < Grape::API
  format :json
  version :v1

  helpers Endpoints::Helpers::APIErrors

  rescue_from Errors::NotFound, with: :not_found
  rescue_from Errors::AlreadyExist, with: :conflict

  mount Endpoints::V1::Mounts::Healthcheck
  mount Endpoints::V1::Mounts::App
end
