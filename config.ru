# frozen_string_literal: true

require_relative 'application'
require_dir 'app'
require_file 'api'

puts '**** Routes API ****'
API.routes.each do |route|
  puts route.instance_variable_get :@options
end

run API
