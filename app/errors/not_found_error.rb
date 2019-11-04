# frozen_string_literal: true

module Errors
  class NotFound < Errors::Http
    def initialize(message = 'Resource not found')
      super(message, 404)
    end
  end
end
