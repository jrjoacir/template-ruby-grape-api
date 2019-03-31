# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'

  add_group 'App', 'app'
  add_group 'Enpoints', 'app/endpoints'
  add_group 'Errors', 'app/errors'
  add_group 'Models', 'app/models'
  add_group 'Services', 'app/services'
  add_group 'Commands', 'app/commands'
  add_group 'Validators', 'app/validators'

  minimum_coverage 100
end
