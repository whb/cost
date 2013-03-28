set :rails_env, "production"

server "cost.xllg.com", :web, :app, :db, :primary => true
set :user, "whb"
set :deploy_to, "/var/www/cost"