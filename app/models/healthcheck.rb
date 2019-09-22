# frozen_string_literal: true

module Models
  class Healthcheck
    attr_reader :date_time, :services

    def initialize(services)
      @date_time = Time.now
      @services = services
    end
  end
end
