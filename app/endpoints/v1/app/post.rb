module Endpoints
  module V1
    module App
      class Post < Grape::API
        desc 'Create application'
        params do
          requires :name, type: String, desc: 'Name'
          optional :description, type: String, desc: 'Description'
        end

        post do
          params.slice!(:name, :description)
          app = Services::App::Create.execute(params)
          present app, with: Endpoints::Entities::App
        end
      end
    end
  end
end
