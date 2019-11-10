# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Put < Grape::API
        desc 'Update project' do
          entity Entities::V1::Project
          failure [{ code: 404,
                     message: 'Project does not exist',
                     model: Entities::V1::Error }]
        end

        params do
          requires :name, type: String, desc: 'Project name',
                          documentation: { param_type: 'body' }
          requires :description, type: String, desc: 'Project description',
                                 documentation: { param_type: 'body' }
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
