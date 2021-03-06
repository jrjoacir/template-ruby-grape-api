# frozen_string_literal: true

module Services
  module Project
    module Update
      def self.execute(id, params)
        project = Validators::Project::Update.execute!(id)
        project.update(params)
        Models::Project[id]
      end
    end
  end
end
