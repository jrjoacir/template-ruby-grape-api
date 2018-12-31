module Validators
  module App
    module Get
      include Validators::App

      def validate!
        not_found!
      end
    end
  end
end
