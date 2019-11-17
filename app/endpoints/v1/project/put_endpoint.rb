# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Put < Grape::API
        desc 'Update project'
        params do
          requires :name, type: String, desc: 'Project name'
          requires :description, type: String, desc: 'Project description'
        end

        put ':id' do
          id = params[:id]
          params.slice!(:name, :description)
          project = Services::Project::Update.execute(id, params)
          present project, with: Entities::V1::Project
        end
      end
    end
  end
end
