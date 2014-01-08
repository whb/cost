class Budget < ActiveRecord::Base
  belongs_to :period
  belongs_to :category
  attr_accessible :amount, :period_id, :category_id
  validates_presence_of :category_id
  
  default_scope :include => :category, :order => "categories.code"
  scope :this_year, joins(:period).where('periods.year' => Date.today.year)

  after_save :clear_cache
  after_destroy :clear_cache

  def clear_cache
    Period.clear_cache_of_category_matched_budget_category
  end

  def available
    amount == nil ? nil : amount - cost
  end

  def cost
    @cost ||= Detail.committed.year(period.year).belongs_to_category(self.category.child_leaf_ids).sum(:price)
  end
end
