# frozen_string_literal: true

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)
require_dirs 'config/initializers'
require_file "config/environments/#{ENV['RACK_ENV']}"
require_dir 'app'
require_file 'api'
