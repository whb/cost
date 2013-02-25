class Category < ActiveRecord::Base
  has_many :budgets
  attr_accessible :code, :name

  def code_name
    code + name
  end
end
