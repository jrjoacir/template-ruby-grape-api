require 'require_smasher'
require_gems 'grape', 'grape-entity', 'pg', 'sequel', 'erb', 'yaml', 'dotenv' 
Dotenv.load(".env.#{ENV['RACK_ENV']}")
require_dirs 'config/initializers', 'app'
