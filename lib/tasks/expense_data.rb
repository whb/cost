#encoding:utf-8

desc "Add expense bills"
task :expenses => :environment do
  
end

desc "Run expense tasks"
task :expense => [ :expenses ]