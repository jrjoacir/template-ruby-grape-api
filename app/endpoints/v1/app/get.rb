# frozen_string_literal: true

module Endpoints
  module V1
    module App
      class Get < Grape::API
        desc 'Application information' do
          entity Entities::V1::App
          failure [{ code: 404,
                     message: 'App does not exist',
                     model: Entities::V1::Error }]
        end

        get do
          app = Services::App::Get.execute
          present app, with: Entities::V1::App
        end
      end
    end
  end
end
