#encoding:utf-8

desc "Add expense with reimbursement bills"
task :expense_with_reimbursements => :environment do
  create_list :expense, 5, :bill_part, :generate_reimbursement
end

task :expenses => :environment do
  create_list :expense, 10, :bill_part
  create_list :expense, 20, :bill_part, :reimbursed
  create_list :expense, 5, :bill_part, :invalid
end

desc "Add reimbursement bills"
task :reimbursements => :environment do
  create_list :reimbursement, 20, :bill_part
end

desc "Add expense bills"
task :bills => [ :expense_with_reimbursements, :expenses, :reimbursements ]
