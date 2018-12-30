module Services
  module Healthcheck
    def self.get
      Models::Healthcheck.new
    end
  end
end
