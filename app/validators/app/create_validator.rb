# frozen_string_literal: true

module Validators
  module App
    module Create
      def self.execute!
        raise Errors::AlreadyExist, 'App already exists' if Models::App.first
      end
    end
  end
end
