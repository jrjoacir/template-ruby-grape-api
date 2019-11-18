# frozen_string_literal: true

module Errors
  class AlreadyExist < Errors::Http
    def initialize(message = 'Resource already exist')
      super(message, 409)
    end
  end
end
