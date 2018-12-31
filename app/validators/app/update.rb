module Validators
  module App
    module Update
      include Validators::App

      def validate!
        not_found!
      end
    end
  end
end
