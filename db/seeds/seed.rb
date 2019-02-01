require_dir 'app'
require 'database_cleaner'

module Seeds
  APP = { name: 'Name', description: 'Description' }

  def self.execute
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean
    Services::App::Create.execute(APP)
  end
end
