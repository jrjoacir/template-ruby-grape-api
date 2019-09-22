# frozen_string_literal: true

module Services
  module Healthcheck
    module Get
      def self.execute
        services = []
        services << Services::Healthcheck::Database.execute
        Models::Healthcheck.new(services)
      end
    end
  end
end
