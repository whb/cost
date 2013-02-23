#encoding:utf-8

FactoryGirl.define do
  factory :organization do
  end

  factory :user do
    sequence(:username) { |n| "test#{n}" }
    sequence(:displayname) { |n| "测试用户#{n}" }
    password "a"
    password_confirmation { |u| u.password }
    enabled true
    roles  %w[admin staff]
  end

  factory :category do
  end

  factory :period do
  end

  factory :budget do
  end

  factory :item do
    expense
    category_id  { rand(1..11) }
    sequence(:name) { |n| "费用......名称#{n}" }
    amount { rand(1..15) }
    unit { ["个", "箱", "台", "套"].sample }
    unit_price { rand(5..900) }
    price { |i| i.unit_price * i.amount }
  end

  factory :expense do
    sn { Expense.generate_sn }
    organization_id { [2, 4, 5, 6].sample }
    sequence(:abstract) { |n| "摘要及......用途#{n}" }
    request_on { (1.month.ago.to_date..Date.today).to_a.sample }
    staff { ["张三", "李四", "王五", "赵六"].sample }
    sequence(:explain) { |n| "填写支出理由、用途说明、购买要求等: 设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;《#{n}》" }
    status { [:edit, :commit, :manager_approval, :general_manager_approval].sample }

    after(:build) do |expense|
      expense.items << FactoryGirl.build_list(:item, rand(1..5), expense: expense)
    end
  end

  factory :detail do
    reimbursement
    category_id  { rand(1..11) }
    sequence(:name) { |n| "费用......名称#{n}" }
    amount { rand(1..15) }
    unit { ["个", "箱", "台", "套"].sample }
    unit_price { rand(5..900) }
    price { |i| i.unit_price * i.amount }
  end

  factory :reimbursement do
    sn { Reimbursement.generate_sn }
    organization_id { [2, 4, 5, 6].sample }
    sequence(:abstract) { |n| "摘要及......用途#{n}" }
    reimburse_on { (1.month.ago.to_date..Date.today).to_a.sample }
    staff { ["张三", "李四", "王五", "赵六"].sample }
    sequence(:invoice_no) { |n| "发票000-000#{n}" }
    status { [:edit, :commit].sample }

    after(:build) do |reimbursement|
      reimbursement.details << FactoryGirl.build_list(:detail, rand(1..5), reimbursement: reimbursement)
      reimbursement.amount = reimbursement.cal_amount
    end
  end

end
