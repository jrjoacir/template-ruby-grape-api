# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Post < Grape::API
        desc 'Create a project' do
          entity Entities::V1::Project
          failure [{ code: 409,
                     message: 'Project already exists',
                     model: Entities::V1::Error }]
        end

        params do
          requires :name, type: String, desc: 'Project name',
                          documentation: { param_type: 'body' }
          optional :description, type: String, desc: 'Project description',
                                 documentation: { param_type: 'body' }
        end

        post do
          params.slice!(:name, :description)
          project = Services::Project::Create.execute(params)
          present project, with: Entities::V1::Project
        end
      end
    end
  end
end
