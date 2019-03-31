# frozen_string_literal: true

module Services
  module App
    class Get
      include Validators::App::Get

      def initialize(app)
        self.app = app
      end

      def self.execute
        new(Models::App.first).execute
      end

      def execute
        validate!
        app
      end

      private

      attr_accessor :app
    end
  end
end
