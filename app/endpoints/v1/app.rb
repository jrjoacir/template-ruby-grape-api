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
    end
  end
end
