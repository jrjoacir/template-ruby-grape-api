# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Delete < Grape::API
        desc 'Delete a project' do
          failure [{ code: 404,
                     message: 'Project does not exist',
                     model: Entities::V1::Error }]
        end

        delete ':id' do
          Services::Project::Delete.execute(params[:id])
          body false
        end
      end
    end
  end
end
