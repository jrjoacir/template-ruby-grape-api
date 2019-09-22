# frozen_string_literal: true

module Services
  module App
    module Create
      def self.execute(params)
        app = Models::App.new(params)
        Validators::App::Create.execute!
        app.save
      end
    end
  end
end
