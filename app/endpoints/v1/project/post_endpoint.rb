# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Post < Grape::API
        desc 'Create a project'
        params do
          requires :name, type: String, desc: 'Project name'
          optional :description, type: String, desc: 'Project description'
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
