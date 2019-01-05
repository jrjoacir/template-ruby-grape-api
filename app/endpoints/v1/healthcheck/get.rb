module Endpoints
  module V1
    module Healthcheck
      class Get < Grape::API
        desc 'Healthcheck information'
        get do
          healthcheck = Services::Healthcheck::Get.execute
          present healthcheck, with: Endpoints::Entities::Healthcheck
        end
      end
    end
  end
end
