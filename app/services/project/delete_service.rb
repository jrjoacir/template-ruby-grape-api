# frozen_string_literal: true

module Services
  module Project
    module Delete
      def self.execute(id)
        project = Models::Project[id]
        Validators::Project::Delete.execute!(project)
        project.delete
      end
    end
  end
end
