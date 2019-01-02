module Endpoints
  module V1
    module App
      class Delete < Grape::API
        desc 'Delete an application'
        delete ':id' do
          Services::App::Delete.execute(params[:id])
          body false
        end
      end
    end
  end
end
