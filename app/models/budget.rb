class Budget < ActiveRecord::Base
  belongs_to :period
  belongs_to :category
  attr_accessible :amount, :period_id, :category_id
  validates_presence_of :category_id

  scope :this_year, joins(:period).where('periods.year' => Date.today.year)

  def available
    amount == nil ? nil : amount - cost
  end

  def cost
    @cost ||= Detail.committed.year(period.year).sum(:price, :conditions => "category_id = #{self.category_id}")
  end

  def self.match_this_year(category)
    b = self.this_year.find_by_category_id(category)
    return b if (b && b.amount)
    self.match_this_year(category.superior) if category.superior
  end

end
