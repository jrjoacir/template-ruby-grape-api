# frozen_string_literal: true

require_relative 'application'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post put delete]
  end
end

puts '**** Routes API ****'
API.routes.each do |route|
  puts route.instance_variable_get :@options
end

run API
