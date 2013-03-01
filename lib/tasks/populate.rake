#encoding:utf-8
require 'factory_girl'
require File.expand_path("lib/tasks/factories.rb")
include FactoryGirl::Syntax::Methods

namespace :populate do
  require File.expand_path("lib/tasks/base_data.rb")
  require File.expand_path("lib/tasks/bills_demo.rb")
  
  desc "Run all populate tasks"
  task :all => [:base, :bills]
end
