class Category < ActiveRecord::Base
  has_many :subordinates, :class_name => "Category", :foreign_key => "superior_id"
  belongs_to :superior, :class_name => "Category"
  has_many :budgets

  attr_accessible :code, :name, :superior_id
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name

  def code_name
    code + name
  end

  def self.father
    f = []
    Category.order(:code).each do |c|
      f << c unless c.leaves.empty?
    end
    f
  end

  def leaves
    l = []
    self.subordinates.each do |c|
      l << c if c.subordinates.empty?
    end
    l
  end
end
