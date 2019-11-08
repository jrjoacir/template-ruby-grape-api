# frozen_string_literal: true

module Endpoints
  module V1
    module Project
      class Get < Grape::API
        desc 'Project information' do
          entity Entities::V1::Project
          failure [{ code: 404,
                     message: 'Project does not exist',
                     model: Entities::V1::Error }]
        end

        get do
          project = Services::Project::Get.execute
          present project, with: Entities::V1::Project
        end
      end
    end
  end
end
