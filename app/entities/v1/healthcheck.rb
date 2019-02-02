module Entities
  module V1
    class Healthcheck < Grape::Entity
      expose :date_time, as: :now
      expose :database, using: Entities::V1::Service

      private

      def database
        object.services[:database]
      end
    end
  end
end
