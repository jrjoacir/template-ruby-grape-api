# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.4'

gem 'grape', '~> 1.3'
gem 'grape-entity', '~> 0.8.0'
gem 'grape_logging', '~> 1.8', '>= 1.8.3'
gem 'pg', '~> 1.2', '>= 1.2.2'
gem 'puma', '~> 4.3'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
gem 'rake', '~> 13.0', '>= 13.0.1'
gem 'require_smasher', '~> 0.4.1'
gem 'sequel', '~> 5.29'

group :test do
  gem 'factory_bot', '~> 5.1', '>= 5.1.1'
  gem 'rack-test', '~> 1.1'
  gem 'rspec', '~> 3.9'
  gem 'simplecov', '~> 0.18.2'
end

group :test, :development do
  gem 'byebug', '~> 11.1', '>= 11.1.1'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.3'
  gem 'racksh', '~> 1.0'
  gem 'rubocop', '~> 0.80.0'
end
