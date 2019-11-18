# frozen_string_literal: true

module Services
  module Project
    module Get
      def self.execute
        project = Models::Project.first
        Validators::Project::Get.execute!(project)

        project
      end
    end
  end
end
