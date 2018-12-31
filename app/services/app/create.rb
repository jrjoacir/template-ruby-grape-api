module Services
  module App
    class Create
      include Validators::App::Create

      def initialize(app)
        self.app = app
      end

      def self.execute(params)
        new(Models::App.new(params)).execute
      end

      def execute
        validate!
        app.save
      end

      private

      attr_accessor :app
    end
  end
end
