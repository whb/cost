set :rails_env, "staging"

server "cost.xllg.com", :web, :app, :db, :primary => true
set :user, "whb"
set :deploy_to, "/var/www/cost_staging"

set :keep_releases, 1