require 'require_smasher'
require_gems 'grape', 'grape-entity', 'grape_logging', 'pg', 'sequel', 'erb'
require_gems 'yaml', 'dotenv'
Dotenv.load(".env.#{ENV['RACK_ENV']}")
require_dirs 'config/initializers'
require_file "config/environments/#{ENV['RACK_ENV']}"
