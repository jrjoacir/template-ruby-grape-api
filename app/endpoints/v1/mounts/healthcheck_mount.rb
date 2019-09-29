# frozen_string_literal: true

module Endpoints
  module Mounts
    class Healthcheck < Grape::API
      namespace :healthcheck do
        mount Endpoints::Healthcheck::Get
      end
    end
  end
end
