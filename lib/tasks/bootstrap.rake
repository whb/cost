namespace :bootstrap do
  desc "Add the admin user"
  task :admin_user => :environment do
    User.create( :username => 'admin', :displayname => 'Admin', :password => 'xldirdos307', :password_confirmation => 'xldirdos307', 
      :enabled => true, :roles => %w[admin] )
  end

  desc "Run all bootstrapping tasks"
  task :all => [:admin_user]
end