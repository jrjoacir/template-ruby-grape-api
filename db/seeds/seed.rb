# frozen_string_literal: true

module Seeds
  PROJECT = { name: 'Name', description: 'Description' }.freeze

  def self.execute
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    Services::Project::Create.execute(PROJECT)
  end
end
