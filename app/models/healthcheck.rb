# frozen_string_literal: true

module Models
  class Healthcheck
    attr_reader :date_time, :services

    def initialize(services)
      self.date_time = Time.now
      self.services = services
    end

    private

    attr_writer :date_time, :services
  end
end
