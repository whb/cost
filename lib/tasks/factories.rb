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
    sequence(:abstract) { |n| "摘要及......用途#{n}" }
    request_on { (1.month.ago.to_date..Date.today).to_a.sample }
    sequence(:staff) { |n| "用户#{n}" }
    organization_id { [2, 4, 5, 6].sample }
    status { [:edit, :commit].sample }

    after(:build) do |expense|
      expense.items << FactoryGirl.build_list(:item, rand(1..5), expense: expense)
    end
  end

end
