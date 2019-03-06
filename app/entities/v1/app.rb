module Entities
  module V1
    class App < Grape::Entity
      expose :id,
             documentation:
             { type: 'integer', desc: 'App id.', required: true }
      expose :name,
             documentation:
             { type: 'string', desc: 'App name.', required: true }
      expose :description,
             documentation:
             { type: 'string', desc: 'App description.', required: false }
    end
  end
end
