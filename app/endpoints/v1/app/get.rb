module Endpoints
  module V1
    module App
      class Get < Grape::API
        desc 'Application information'
        get do
          app = Services::App::Get.execute
          present app, with: Endpoints::Entities::App
        end
      end
    end
  end
end
