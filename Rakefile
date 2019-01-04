# TODO: Create a task for create and drop database
ENV['RACK_ENV'] ||= 'development'

require_relative 'application'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    version = args[:version].to_i if args[:version]
    ORM::Database.migrate(version)
  end
end
