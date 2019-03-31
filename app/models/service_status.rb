# frozen_string_literal: true

module Models
  class ServiceStatus
    attr_reader :status, :duration, :error

    def initialize(status, duration, error)
      self.status = status
      self.duration = duration
      self.error = error
    end

    private

    attr_writer :status, :duration, :error
  end
end
