# frozen_string_literal: true

module Validators
  module Project
    module Update
      def self.execute!(id)
        project = Models::Project[id]
        raise Errors::NotFound, 'Project does not exist' unless project

        project
      end
    end
  end
end
