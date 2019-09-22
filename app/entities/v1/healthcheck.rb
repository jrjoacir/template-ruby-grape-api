# frozen_string_literal: true

module Entities
  module V1
    class Healthcheck < Grape::Entity
      expose :date_time, as: :now
      expose :services, using: Entities::V1::Service
    end
  end
end
