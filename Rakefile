# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default)

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    puts 'Running migration ...'
    require_dirs 'config/initializers'
    version = args[:version].to_i if args[:version]
    ORM::Database.migrate(version)
    puts 'Migration finished!'
  end

  desc 'Run seeds'
  task :seeds do
    puts 'Running seeds ...'
    require_file 'application'
    require_relative 'db/seeds/seed'
    error_message = 'Seeds only can be executed in Development environment'
    raise StandardError, error_message unless ENV['RACK_ENV'] == 'development'

    Seeds.execute
    puts 'Seeds finished!'
  end
end

task :default do
  'Finished!'
end
