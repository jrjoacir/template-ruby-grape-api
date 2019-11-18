# frozen_string_literal: true

module Errors
  class Http < RuntimeError
    attr_reader :http_status

    def initialize(message, http_status)
      error_message = "HttpStatus #{http_status} does not represent a http error"
      raise error_message unless http_status.between?(400, 599)

      @http_status = http_status
      super(message)
    end
  end
end
