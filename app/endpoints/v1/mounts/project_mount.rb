# frozen_string_literal: true

module Endpoints
  module V1
    module Mounts
      class Project < Grape::API
        namespace :projects do
          mount Endpoints::V1::Project::Post
          mount Endpoints::V1::Project::Delete
          mount Endpoints::V1::Project::Put
          mount Endpoints::V1::Project::Get
        end
      end
    end
  end
end
