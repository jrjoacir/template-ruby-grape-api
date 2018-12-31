module Validators
  module App
    module Create
      def validate!
        validate_uniq!
        validate_name!
      end

      def validate_uniq!
        raise StandardError, 'App already exists' if Models::App.first
      end

      def validate_name!
        raise StandardError, 'App name is not informed' unless app.name
      end
    end
  end
end