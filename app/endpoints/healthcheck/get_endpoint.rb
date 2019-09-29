# frozen_string_literal: true

module Endpoints
  module Healthcheck
    class Get < Grape::API
      desc 'Healthcheck information'
      get do
        healthcheck = Services::Healthcheck::Get.execute
        present healthcheck, with: Entities::Healthcheck
      end
    end
  end
end
