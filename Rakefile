ENV['RACK_ENV'] ||= 'development'

require_relative 'application'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    version = args[:version].to_i if args[:version]
    ORM::Database.migrate(version)
  end

  task :seeds do
    require_relative 'db/seeds/seed'
    error_message = 'Seeds only can be executed in Development environment'
    raise StandardError, error_message unless ENV['RACK_ENV'] == 'development'

    Seeds.execute
  end
end
