# frozen_string_literal: true

require_dir 'app'
require 'database_cleaner'

module Seeds
  APP = { name: 'Name', description: 'Description' }.freeze

  def self.execute
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    Services::App::Create.execute(APP)
  end
end
