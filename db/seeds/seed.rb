# frozen_string_literal: true

module Seeds
  APP = { name: 'Name', description: 'Description' }.freeze

  def self.execute
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    Services::App::Create.execute(APP)
  end
end
