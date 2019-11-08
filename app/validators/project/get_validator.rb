# frozen_string_literal: true

module Validators
  module Project
    module Get
      def self.execute!(project)
        raise Errors::NotFound, 'Project does not exist' unless project
      end
    end
  end
end
