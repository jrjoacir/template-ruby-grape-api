# frozen_string_literal: true

module HelpersApp
  module APIErrors
    def not_found(exception)
      error!({ message: exception.message, with: Entities::V1::Error }, 404)
    end

    def conflict(exception)
      error!({ message: exception.message, with: Entities::V1::Error }, 409)
    end
  end
end
