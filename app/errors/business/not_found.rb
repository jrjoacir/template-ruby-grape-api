module Errors
  module Business
    class NotFound < StandardError
      def initialize(message = 'Resource not found')
        super
      end
    end
  end
end
