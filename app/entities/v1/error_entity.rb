# frozen_string_literal: true

module Entities
  module V1
    class Error < Grape::Entity
      expose :message,
             documentation: { type: 'string',
                              desc: 'Message error.',
                              required: true }
    end
  end
end
