module Models
  class Healthcheck
    attr_reader :status, :date_time

    def initialize
      self.date_time = Time.now
      self.status = 'OK'
    end

    private

    attr_writer :status, :date_time
  end
end
