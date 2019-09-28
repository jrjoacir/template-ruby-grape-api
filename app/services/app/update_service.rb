# frozen_string_literal: true

module Services
  module App
    module Update
      def self.execute(id, params)
        app = Validators::App::Update.execute!(id)
        app.update(params)
      end
    end
  end
end
