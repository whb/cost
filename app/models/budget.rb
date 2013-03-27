class Budget < ActiveRecord::Base
  belongs_to :period
  belongs_to :category
  attr_accessible :amount, :period_id, :category_id
  validates_presence_of :category_id
  
  default_scope :include => :category, :order => "categories.code"
  scope :this_year, joins(:period).where('periods.year' => Date.today.year)

  after_save :clear_cache_of_match_budget_category_hash
  after_destroy :clear_cache_of_match_budget_category_hash

  def clear_cache_of_match_budget_category_hash
    Category.clear_cache_of_match_budget_category_hash
  end

  def available
    amount == nil ? nil : amount - cost
  end

  def cost
    @cost ||= Detail.committed.year(period.year).belongs_to_category(self.category.child_leaf_ids).sum(:price)
  end

  def self.match_this_year(category)
    b = self.this_year.find_by_category_id(category)
    return b if (b && b.amount)
    self.match_this_year(category.superior) if category.superior
  end

end
