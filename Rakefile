ENV['RACK_ENV'] ||= 'development'

require_relative 'application'
require_relative 'db/seeds/seed'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    version = args[:version].to_i if args[:version]
    ORM::Database.migrate(version)
  end

  task :seeds do
    Seeds.execute
  end
end
