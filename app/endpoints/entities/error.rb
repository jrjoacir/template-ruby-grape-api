module Endpoints
  module Entities
    class Error < Grape::Entity
      expose :message
    end
  end
end
