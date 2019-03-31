# frozen_string_literal: true

module Services
  module App
    class Delete
      include Validators::App::Delete

      def initialize(app)
        self.app = app
      end

      def self.execute(id)
        new(Models::App[id]).execute
      end

      def execute
        validate!
        app.delete
      end

      private

      attr_accessor :app
    end
  end
end
