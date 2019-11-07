export $(cat .env.test) && rake db:migrate
export $(cat .env.development) && rake db:migrate && rake db:seeds
