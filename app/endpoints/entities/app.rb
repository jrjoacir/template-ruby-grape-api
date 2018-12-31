module Endpoints
  module Entities
    class App < Grape::Entity
      expose :id
      expose :name
      expose :description
    end
  end
end
