module Endpoints
  module V1
    module App
      class Put < Grape::API
        desc 'Update application'
        params do
          requires :name, type: String, desc: 'Name'
          requires :description, type: String, desc: 'Description'
        end

        put ':id' do
          id = params[:id]
          params.slice!(:name, :description)
          app = Services::App::Update.execute(id, params)
          present app, with: Endpoints::Entities::App
        end
      end
    end
  end
end
