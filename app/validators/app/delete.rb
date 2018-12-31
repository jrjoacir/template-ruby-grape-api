module Validators
  module App
    module Delete
      def validate!
        raise StandardError, 'App does not exist' unless app
      end
    end
  end
end