module Validators
  module App
    module Delete
      include Validators::App

      def validate!
        not_found!
      end
    end
  end
end
