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



  trait :item_detail_part do
    category_id  { rand(1..11) }
    sequence(:name) { |n| "费用名称......#{n}" }
    amount { rand(1..10) }
    unit { ["个", "箱", "台", "套"].sample }
    unit_price { [1, 5, 10, 50, 100, 200, 1000, 2000, 5000].sample }
    price { |i| i.unit_price * i.amount }
  end

  trait :bill_part do
    organization_id { [2, 4, 5, 6].sample }
    sequence(:abstract) { |n| "摘要及用途......#{n}" }
    staff { ["张三", "李四", "王五", "赵六"].sample }
  end

  factory :item do
    expense
  end

  factory :expense do
    sn { Expense.generate_sn }
    request_on { (2.month.ago.to_date..Date.today).to_a.sample }
    sequence(:explain) { |n| "填写支出理由、用途说明、购买要求等: 设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;设备已经报废，需要更新; 该经费用于购买演出服装; 请注意机箱的钢板厚度;《#{n}》" }
    status { [:edit, :commit, :manager_approval, :general_manager_approval].sample }

    after(:build) do |expense|
      expense.items << FactoryGirl.build_list(:item, rand(1..5), :item_detail_part, expense: expense)
    end

    trait :reimbursed do
      status :reimbursed
      explain "已报销xxxxxxxxxxxxxx"
    end

    trait :invalid do
      status :invalid
      explain "作废xxxxxxxxxxx"
    end

    trait :generate_reimbursement do
      status :general_manager_approval

      after(:build) do |expense|
        expense.abstract = "测试关联 : " + expense.abstract
      end

      after(:create) do |expense|
        r = Reimbursement.new_from_expense(expense, nil)
        r.staff = expense.staff
        r.organization = expense.organization
        r.reimburse_on = expense.request_on
        r.invoice_no = "发票000-000xxx"
        r.status = :edit
        r.save!
      end
    end
  end

  factory :detail do
    reimbursement
  end

  factory :reimbursement do
    sn { Reimbursement.generate_sn }
    reimburse_on { (1.month.ago.to_date..Date.today).to_a.sample }
    sequence(:invoice_no) { |n| "发票000-000#{n}" }
    status { [:edit, :commit].sample }

    after(:build) do |reimbursement|
      reimbursement.details << FactoryGirl.build_list(:detail, rand(1..5), :item_detail_part, reimbursement: reimbursement)
      reimbursement.amount = reimbursement.cal_amount
    end
  end

end
