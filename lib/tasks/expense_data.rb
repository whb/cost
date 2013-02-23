#encoding:utf-8

desc "Add expense bills"
task :expenses => :environment do
  create_list :expense, 50
  create_list :expense, 100, status: :reimbursed, explain: "已报销xxxxxxxxxxxxxx"
  create_list :expense, 10, status: :invalid, explain: "作废xxxxxxxxxxx"
end

desc "Run expense tasks"
task :expense => [ :expenses ]