#encoding:utf-8

namespace :bootstrap do
  desc "Add the admin user"
  task :admin_user => :environment do
    User.create( :username => 'admin', :displayname => '<管理员>', :password => 'xldirdos307', :password_confirmation => 'xldirdos307',
                 :enabled => true, :roles => %w[admin], :organization_id => 0)
  end

  desc "Create the default organizations"
  task :default_organizations => :environment do
    Organization.create(:id => 1, :code => '001', :name => '《祥龙物流》' )
    Organization.create(:id => 2, :code => '002', :name => '行政办公室', :superior_id => 1 )
    Organization.create(:id => 3, :code => '003', :name => '[企管信息]', :superior_id => 1 )
    Organization.create(:id => 4, :code => '004', :name => '企管部', :superior_id => 3 )
    Organization.create(:id => 5, :code => '005', :name => '信息部', :superior_id => 3 )
    Organization.create(:id => 6, :code => '006', :name => '财务部', :superior_id => 1 )
  end

  desc "Create the default users"
  task :default_users => :environment do
    User.create( :username => 'whb', :displayname => '吴海波', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[staff department_manager], :organization_id => 5)
    User.create( :username => 'guo', :displayname => '郭文静', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[admin staff], :organization_id => 5)
    User.create( :username => 'wu', :displayname => '吴继友', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[staff department_manager], :organization_id => 4)
    User.create( :username => 'han', :displayname => '韩长生', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[vice_manager], :organization_id => 3)
    User.create( :username => 'ma', :displayname => '马昕', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[general_manager], :organization_id => 1)
    User.create( :username => 'song', :displayname => '宋悦', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[financial_officer], :organization_id => 6)
  end

  desc "Create the default categories"
  task :default_categories => :environment do
    Category.create(:id => 1, :code => '01-001', :name => '办公家具' )
    Category.create(:id => 2, :code => '01-002', :name => '办公设备' )
    Category.create(:id => 3, :code => '01-003', :name => '办公耗材' )
    Category.create(:id => 4, :code => '02-001', :name => '差旅费' )
    Category.create(:id => 5, :code => '02-002', :name => '会务费' )
    Category.create(:id => 6, :code => '03-001', :name => '慰问费(行政)' )
    Category.create(:id => 7, :code => '03-002', :name => '慰问费(政工)' )
    Category.create(:id => 8, :code => '04-001', :name => '计算机设备' )
    Category.create(:id => 9, :code => '04-002', :name => '网络设备' )
    Category.create(:id => 10, :code => '04-003', :name => '计算机维修费' )
    Category.create(:id => 11, :code => '05-001', :name => '软件开发费' )
  end

  desc "Create the default periods"
  task :default_periods => :environment do
    Period.create(:id => 1, :year => 2013, :explain => '2012年度预算' )
  end

  desc "Create the default budget"
  task :default_budgets => :environment do
    Budget.create(:period_id => 1, :category_id => 1, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 2, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 3, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 4, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 5, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 6, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 7, :amount => 50000 )
    Budget.create(:period_id => 1, :category_id => 8, :amount => 25000 )
    Budget.create(:period_id => 1, :category_id => 9, :amount => 15000 )
    Budget.create(:period_id => 1, :category_id => 10, :amount => 20000 )
  end

  desc "Create the test users"
  task :test_users => :environment do
    User.create( :username => 'test', :displayname => '测试用户', :password => 'a', :password_confirmation => 'a',
                 :enabled => true, :roles => %w[admin staff department_manager vice_manager general_manager financial_officer], 
                 :organization_id => 5)
  end

  desc "Run all bootstrapping tasks"
  task :init => [:admin_user, :default_organizations, :default_users, :default_categories, :default_periods, :default_budgets]
  task :all => [:init, :test_users]
end
