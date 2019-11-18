# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Get < Grape::API
        desc 'Project information'
        get do
          project = Services::Project::Get.execute
          present project, with: Entities::V1::Project
        end
      end
    end
  end
end
