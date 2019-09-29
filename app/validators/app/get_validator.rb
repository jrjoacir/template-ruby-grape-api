# frozen_string_literal: true

module Validators
  module App
    module Get
      def self.execute!(app)
        raise Errors::NotFound, 'App does not exist' unless app
      end
    end
  end
end
