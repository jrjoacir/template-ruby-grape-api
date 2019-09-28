# frozen_string_literal: true

module Services
  module Healthcheck
    module Get
      def self.execute
        Models::Healthcheck.new
      end
    end
  end
end
