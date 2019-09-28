# frozen_string_literal: true

module Services
  module App
    module Delete
      def self.execute(id)
        app = Models::App[id]
        Validators::App::Delete.execute!(app)
        app.delete
      end
    end
  end
end
