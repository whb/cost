class Category < ActiveRecord::Base
  belongs_to :major_category
  has_many :budgets

  attr_accessible :code, :name, :major_category_id
  validates_presence_of :code, :name, :major_category_id
  validates_uniqueness_of :code, :name

  def code_name
    code + name
  end
end
