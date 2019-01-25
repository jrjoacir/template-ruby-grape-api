module Endpoints
  module V1
    module Mounts
      class Healthcheck < Grape::API
        namespace :healthcheck do
          mount Endpoints::V1::Healthcheck::Get
        end
      end
    end
  end
end
