class Category < ActiveRecord::Base
  has_many :subordinates, :class_name => "Category", :foreign_key => "superior_id"
  belongs_to :superior, :class_name => "Category"
  has_many :budgets

  attr_accessible :code, :name, :superior_id
  validates_presence_of :code, :name
  validates_uniqueness_of :code

  default_scope  :order => :code

  def code_name
    code + name
  end

  def level
    return 1 if code.length == 1
    return 2 if code.length == 3
    return 3 if code.length == 5
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

  def child_leaf_ids
    child_categories = []
    subs = self.subordinates
    if subs.empty?
      child_categories << self.id
    else
      subs.each do |c|
        child_categories << c.child_leaf_ids
      end
    end
    child_categories.flatten
  end

  def branch_node?
    !self.subordinates.empty?
  end

  def match_budget
    Budget.match_this_year(self)
  end

  def self.match_budget_category_hash
    hash = {}
    Category.all.each do |c|
      b = Budget.match_this_year(c)
      hash[c.id] = b.category.id if b
    end
    hash
  end

end
