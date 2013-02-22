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

  factory :expense do
  end
end
