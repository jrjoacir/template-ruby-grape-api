module Services
  module App
    class Update
      include Validators::App::Update

      def initialize(app, params)
        self.app = app
        self.params = params
      end

      def self.execute(id, params)
        app = Models::App[id]
        new(app, params).execute
      end

      def execute
        validate!
        app_updated = app.update(params)
        return app unless app_updated

        app_updated
      end

      private

      attr_accessor :app, :params
    end
  end
end
