module Endpoints
  module Helpers
    module APIErrors
      def not_found(exception)
        error!({ message: exception.message,
                 with: Endpoints::Entities::Error }, 404)
      end

      def conflict(exception)
        error!({ message: exception.message,
                 with: Endpoints::Entities::Error }, 409)
      end
    end
  end
end
