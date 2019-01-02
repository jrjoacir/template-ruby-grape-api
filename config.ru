require_relative 'application'

puts '**** Routes API ****'
API.routes.each do |route|
  puts route.instance_variable_get :@options
end

run API
