module Entities
  module V1
    class Service < Grape::Entity
      expose :status
      expose :duration
      expose :error, expose_nil: false
    end
  end
end
