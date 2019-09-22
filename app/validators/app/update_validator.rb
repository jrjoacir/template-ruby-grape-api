# frozen_string_literal: true

module Validators
  module App
    module Update
      def self.execute!(id)
        app = Models::App[id]
        raise Errors::NotFound, 'App does not exist' unless app

        app
      end
    end
  end
end
