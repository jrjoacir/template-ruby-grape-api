# frozen_string_literal: true

module Validators
  module Project
    module Create
      def self.execute!
        raise Errors::AlreadyExist, 'Project already exists' if Models::Project.first
      end
    end
  end
end
