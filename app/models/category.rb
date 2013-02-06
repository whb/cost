class Category < ActiveRecord::Base
  has_many :budgets
  attr_accessible :code, :name
end
