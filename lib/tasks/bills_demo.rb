#encoding:utf-8

desc "Add expense with reimbursement bills"
task :expense_with_reimbursements => :environment do
  
end

task :expenses => :environment do
  5.times do |i|
    expense = Expense.new
    expense.sn = Expense.generate_sn
    expense.organization = @whb.organization
    expense.staff = @whb.displayname
    expense.request_on = (2.month.ago.to_date..Date.today).to_a.sample
    expense.abstract = "演示：摘要及用途......#{i}"
    expense.explain = "演示：填写支出理由、用途说明、购买要求等: 设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;《#{i}》"
    expense.status = [:edit, :commit, :manager_approval, :general_manager_approval].sample
    rand(1..5).times do |n|
      item = expense.items.build
      item.category_id = rand(1..11)
      item.name = "费用......#{n}"
      item.amount = rand(1..10) 
      item.unit = ["个", "箱", "台", "套"].sample
      item.unit_price = [1, 5, 10, 50, 100, 200, 1000, 2000, 5000].sample 
      item.price = item.unit_price * item.amount
   end
   expense.save!
  end
end

desc "Add reimbursement bills"
task :reimbursements => :environment do
 
end

desc "Add expense bills"
task :bills => [ :expense_with_reimbursements, :expenses, :reimbursements ]
