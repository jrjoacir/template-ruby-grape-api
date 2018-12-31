module Services
  module App
    module Get
      def self.execute
        Models::App.first
      end
    end
  end
end
