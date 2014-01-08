class Period < ActiveRecord::Base
  has_many :budgets, :dependent => :destroy
  accepts_nested_attributes_for :budgets, :allow_destroy => true
  attr_accessible :explain, :year, :budgets_attributes
  validates_presence_of :year

  def self.new_blank
    period = Period.new
    Category.order(:code).each do |c|
      b = period.budgets.build
      b.category = c
    end
    period
  end

  def append_new_categories
    exist_categories = self.budgets.map { |b| b.category }
    Category.order(:code).each do |c|
      unless exist_categories.include?(c) 
        b = self.budgets.build
        b.category = c
      end
    end
  end

  def order_budgets
    self.budgets.joins(:category).order('categories.code')
  end

  # ----------------------------

  def budget_by_category(category)
    b = budgets.find_by_category_id(category)
    return b if (b && b.amount)
    self.budget_by_category(category.superior) if category.superior
  end

  def build_category_matched_budget_category
    hash = {}
    Category.all.each do |c|
      b = budget_by_category(c)
      hash[c.id] = b.category.id if b
    end
    hash
  end

  def category_matched_budget_category
    @@period_matched_hash ||= {}
    @@period_matched_hash[self.id] ||= build_category_matched_budget_category
  end

  def self.clear_cache_of_category_matched_budget_category
    @@period_matched_hash = nil
  end

  def matched?(c, budget_c)
    budget_c.id == category_matched_budget_category[c.id]
  end

end
