module Validators
  module App
    module Update
      def validate!
        raise StandardError, 'App does not exist' unless app
      end
    end
  end
end
