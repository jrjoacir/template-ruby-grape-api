# frozen_string_literal: true

module Entities
  module V1
    class Project < Grape::Entity
      expose :id,
             documentation:
             { type: 'integer', desc: 'Project id.', required: true }
      expose :name,
             documentation:
             { type: 'string', desc: 'Project name.', required: true }
      expose :description,
             documentation:
             { type: 'string', desc: 'Project description.', required: false }
    end
  end
end
