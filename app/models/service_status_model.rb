# frozen_string_literal: true

module Models
  class ServiceStatus
    attr_reader :name, :status, :duration, :error

    def initialize(name, status, duration, error = nil)
      @name = name
      @status = status
      @duration = duration
      @error = error
    end
  end
end
