#encoding:utf-8

namespace :bootstrap do
  desc "Add the admin user"
  task :admin_user => :environment do
    User.create( :username => 'admin', :displayname => '<管理员>', :password => 'xldirdos307', :password_confirmation => 'xldirdos307', 
      :enabled => true, :roles => %w[admin], :organization_id => 0)
  end

  desc "Create the default organization"
    task :default_organization => :environment do
      Organization.create(:id => 1, :code => '001', :name => '《祥龙物流》' )
      Organization.create(:id => 2, :code => '002', :name => '行政办公室', :superior_id => 1 )
      Organization.create(:id => 3, :code => '003', :name => '[企管信息]', :superior_id => 1 )
      Organization.create(:id => 4, :code => '004', :name => '企管部', :superior_id => 3 )
      Organization.create(:id => 5, :code => '005', :name => '信息部', :superior_id => 3 )
    end

  desc "Run all bootstrapping tasks"
  task :all => [:admin_user, :default_organization]
end