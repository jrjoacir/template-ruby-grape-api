module Endpoints
  module V1
    class App < Grape::API
      desc 'Application information'
      get do
        app = Services::App::Get.execute
        present app, with: Endpoints::Entities::App
      end

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

      desc 'Delete an application'
      delete ':id' do
        Services::App::Delete.execute(params[:id])
        body false
      end
    end
  end
end
