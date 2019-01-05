module Endpoints
  module Entities
    class Healthcheck < Grape::Entity
      expose :date_time, as: :now
      expose :database, using: Endpoints::Entities::Service

      private

      def database
        object.services[:database]
      end
    end
  end
end
