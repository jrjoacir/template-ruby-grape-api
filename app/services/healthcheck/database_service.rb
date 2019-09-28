# frozen_string_literal: true

module Services
  module Healthcheck
    module Database
      NAME = 'Database'

      def self.execute
        start = Time.now

        begin
          ORM::Database.test!
          Models::ServiceStatus.new(NAME, 'OK', Time.now - start)
        rescue StandardError => error
          Models::ServiceStatus.new(NAME, 'NOT_OK', Time.now - start, error.class)
        end
      end
    end
  end
end
