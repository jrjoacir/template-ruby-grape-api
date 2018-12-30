module Endpoints
  module Entities
    class Healthcheck < Grape::Entity
      expose :status
      expose :date_time, as: :now
    end
  end
end
