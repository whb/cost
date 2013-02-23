#encoding:utf-8

desc "Add expense bills"
task :expenses => :environment do
  create_list :expense, 20
  create_list :expense, 10, status: :reimbursed, explain: "已报销xxxxxxxxxxxxxx"
  create_list :expense, 10, status: :invalid, explain: "作废xxxxxxxxxxx"
end

desc "Add reimbursement bills"
task :reimbursements => :environment do
  create_list :reimbursement, 20
end

desc "Run expense tasks"
task :bills => [ :expenses, :reimbursements ]