class Category < ActiveRecord::Base
  has_many :budgets
  attr_accessible :code, :name
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name

  def code_name
    code + name
  end
end
