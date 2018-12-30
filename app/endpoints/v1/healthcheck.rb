module Endpoints
  module V1
    class Healthcheck < Grape::API
      desc 'Healthcheck'
      get do
        healthcheck = Services::Healthcheck.get
        present healthcheck, with: Endpoints::Entities::Healthcheck
      end
    end
  end
end
