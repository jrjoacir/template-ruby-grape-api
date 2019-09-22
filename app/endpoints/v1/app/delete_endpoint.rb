# frozen_string_literal: true

module Endpoints
  module V1
    module App
      class Delete < Grape::API
        desc 'Delete an application' do
          failure [{ code: 404,
                     message: 'App does not exist',
                     model: Entities::V1::Error }]
        end

        delete ':id' do
          Services::App::Delete.execute(params[:id])
          body false
        end
      end
    end
  end
end
