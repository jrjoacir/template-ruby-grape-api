RACK_ENV=development rake db:migrate
RACK_ENV=development rake db:seeds
RACK_ENV=test rake db:migrate
puma -p 3000
