# frozen_string_literal: true

module Entities
  class Healthcheck < Grape::Entity
    expose :date_time, as: :now
    expose :database, using: Entities::V1::Service
  end
end
