#require "bundler/capistrano" 
require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "cost"
set :repository,  "git://github.com/whb/cost.git"
set :scm, :git 
set :deploy_via, :remote_cache

# server "rost.xllg.com", :web, :app, :db, :primary => true
# set :user, "whb"
# set :deploy_to, "/var/www/cost"
default_run_options[:pty] = true
set :use_sudo, false

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end