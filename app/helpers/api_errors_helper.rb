# frozen_string_literal: true

module HelpersApp
  module APIErrors
    def error(http_error)
      error!({ message: http_error.message, with: Entities::V1::Error }, http_error.http_status)
    end
  end
end
