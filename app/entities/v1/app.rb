module Entities
  module V1
    class App < Grape::Entity
      expose :id
      expose :name
      expose :description
    end
  end
end
