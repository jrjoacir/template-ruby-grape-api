# frozen_string_literal: true

module Endpoints
  module V1
    module Mounts
      class App < Grape::API
        namespace :app do
          mount Endpoints::V1::App::Post
          mount Endpoints::V1::App::Delete
          mount Endpoints::V1::App::Put
          mount Endpoints::V1::App::Get
        end
      end
    end
  end
end
