# frozen_string_literal: true

module Models
  class Healthcheck
    attr_reader :date_time, :database

    def initialize
      @date_time = Time.now
      @database = Services::Healthcheck::Database.execute
    end
  end
end
