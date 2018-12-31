module Errors
  module Business
    class AlreadyExist < StandardError
      def initialize(message = 'Resource already exist')
        super
      end
    end
  end
end
