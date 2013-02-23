#encoding:utf-8

desc "Add expense bills"
task :expenses => :environment do
  create_list :expense, 50
end

desc "Run expense tasks"
task :expense => [ :expenses ]