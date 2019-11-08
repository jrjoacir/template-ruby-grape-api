# frozen_string_literal: true

module Services
  module Project
    module Create
      def self.execute(params)
        project = Models::Project.new(params)
        Validators::Project::Create.execute!
        project.save
      end
    end
  end
end
