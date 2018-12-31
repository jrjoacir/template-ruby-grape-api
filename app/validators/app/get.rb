module Validators
  module App
    module Get
      def validate!
        raise StandardError, 'App does not exist' unless app
      end
    end
  end
end