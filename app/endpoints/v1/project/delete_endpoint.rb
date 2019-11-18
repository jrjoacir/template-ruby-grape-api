# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Delete < Grape::API
        desc 'Delete a project'
        delete ':id' do
          Services::Project::Delete.execute(params[:id])
          body false
        end
      end
    end
  end
end
