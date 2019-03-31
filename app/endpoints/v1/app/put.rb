# frozen_string_literal: true

module Endpoints
  module V1
    module App
      class Put < Grape::API
        desc 'Update application' do
          entity Entities::V1::App
          failure [{ code: 404,
                     message: 'App does not exist',
                     model: Entities::V1::Error }]
        end

        params do
          requires :name, type: String, desc: 'App name',
                          documentation: { param_type: 'body' }
          requires :description, type: String, desc: 'App description',
                                 documentation: { param_type: 'body' }
        end

        put ':id' do
          id = params[:id]
          params.slice!(:name, :description)
          app = Services::App::Update.execute(id, params)
          present app, with: Entities::V1::App
        end
      end
    end
  end
end
