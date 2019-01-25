module Errors
  class NotFound < StandardError
    def initialize(message = 'Resource not found')
      super
    end
  end
end
