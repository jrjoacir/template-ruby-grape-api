# frozen_string_literal: true

module Services
  module App
    module Get
      def self.execute
        app = Models::App.first
        Validators::App::Get.execute!(app)

        app
      end
    end
  end
end
