module Endpoints
  module V1
    module App
      class Post < Grape::API
        desc 'Create an application' do
          entity Entities::V1::App
          failure [{ code: 409,
                     message: 'App already exists',
                     model: Entities::V1::Error }]
        end

        params do
          requires :name, type: String, desc: 'App name',
                          documentation: { param_type: 'body' }
          optional :description, type: String, desc: 'App description',
                                 documentation: { param_type: 'body' }
        end

        post do
          params.slice!(:name, :description)
          app = Services::App::Create.execute(params)
          present app, with: Entities::V1::App
        end
      end
    end
  end
end
