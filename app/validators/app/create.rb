module Validators
  module App
    module Create
      include Validators::App

      def validate!
        already_exist!
      end
    end
  end
end
