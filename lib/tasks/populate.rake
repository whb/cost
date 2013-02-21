#encoding:utf-8

namespace :populate do
  desc "Create the test users"
  task :test_users => :environment do
    require 'factory_girl'

    humen_organization = Organization.create(:code => '007', :name => '人力资源部', :superior_id => 1 )

    100.times do |i|
      User.create(:username => "test#{i}", :displayname => "测试用户#{i}", 
                  :password => 'a', :password_confirmation => 'a',
                  :enabled => true, :roles => %w[admin staff], 
                  :organization => humen_organization)
    end
  end

  desc "Run all populate tasks"
  task :all => [:test_users]
end
